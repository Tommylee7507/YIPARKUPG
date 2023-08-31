codeunit 50043 "DK_Reagree To Prov. Mgt"
{
    // 
    // // „ÏŸ ý ‹²ŒŠ
    // 
    // DK34 : 20201023
    //   - Create


    trigger OnRun()
    begin

        BatchDailyReagreeToProvInfo('', 0);
    end;

    var
        Customer: Record DK_Customer;
        RelationshipFamily: Record "DK_Relationship Family";
        MSG001: Label 'The list generation scheduler for the re-operation of information provision was operated normally.';


    procedure BatchDailyReagreeToProvInfo(pSourceNo: Code[20]; pSourceLineNo: Integer)
    var
        _ExpirationDate: Date;
        _ReagreeToProvideInfo: Record "DK_Reagree To Provide Info";
        _CommFun: Codeunit "DK_Common Function";
    begin
        // Customer : pSourceNo ˆˆ ¯‡’
        // RelationshipFamily : pSourceNo, pSourceLineNo ¯‡’

        Clear(Customer);
        Clear(RelationshipFamily);

        _ReagreeToProvideInfo.Reset;
        _ReagreeToProvideInfo.SetRange("Creation Base Date", Today);
        _ReagreeToProvideInfo.SetRange("Send Type", false);

        _ExpirationDate := CalcDate('<-2Y>', Today) + 2;

        Customer.SetFilter("No.", '<>%1', '');
        RelationshipFamily.SetFilter("Contract No.", '<>%1', '');
        RelationshipFamily.SetFilter("Line No.", '<>%1', 0);

        if (pSourceNo <> '') and (pSourceLineNo <> 0) then begin
            _ReagreeToProvideInfo.SetRange("Source No.", pSourceNo);
            _ReagreeToProvideInfo.SetRange("Source Line No.", pSourceLineNo);

            RelationshipFamily.SetRange("Contract No.", pSourceNo);
            RelationshipFamily.SetRange("Line No.", pSourceLineNo);
        end else
            if (pSourceNo <> '') and (pSourceLineNo = 0) then begin
                _ReagreeToProvideInfo.SetRange("Source No.", pSourceNo);
                Customer.SetRange("No.", pSourceNo);
            end;

        if _ReagreeToProvideInfo.FindSet then
            _ReagreeToProvideInfo.DeleteAll(true);

        Customer.SetRange("Request Del", false);
        Customer.SetRange("Personal Data", true);
        Customer.SetRange(Status, Customer.Status::Released);
        Customer.SetFilter("Personal Data Concu. Date", '<>%1&<%2', 0D, _ExpirationDate);
        Customer.SetFilter("Reagree Prov. Info Send Date", '%1', 0D);
        if Customer.FindSet then begin
            _ReagreeToProvideInfo.Reset;
            _ReagreeToProvideInfo.SetRange("Send Type", false);
            repeat
                _ReagreeToProvideInfo.SetRange("Source No.", Customer."No.");
                if not _ReagreeToProvideInfo.FindSet then
                    InsertReagreeToProvInfoWithCustomer();
            until Customer.Next = 0;
        end;

        RelationshipFamily.SetRange("Personal Data", true);
        RelationshipFamily.SetFilter("Personal Data Concu. Date", '<>%1&<%2', 0D, _ExpirationDate);
        RelationshipFamily.SetFilter("Reagree Prov. Info Send Date", '%1', 0D);
        if RelationshipFamily.FindSet then begin
            _ReagreeToProvideInfo.Reset;
            _ReagreeToProvideInfo.SetRange("Send Type", false);
            repeat
                _ReagreeToProvideInfo.SetRange("Source No.", RelationshipFamily."Contract No.");
                _ReagreeToProvideInfo.SetRange("Source Line No.", RelationshipFamily."Line No.");
                if not _ReagreeToProvideInfo.FindSet then
                    InsertReagreeToProvInfoWithRelationshipFam();
            until RelationshipFamily.Next = 0;
        end;

        // Add Code
        Customer.SetRange("Request Del", false);
        Customer.SetRange("Personal Data", true);
        Customer.SetRange(Status, Customer.Status::Released);
        Customer.SetFilter("Personal Data Concu. Date", '<>%1&<%2', 0D, _ExpirationDate);
        Customer.SetFilter("Reagree Prov. Info Send Date", '<>%1&<%2', 0D, _ExpirationDate);
        if Customer.FindSet then begin
            _ReagreeToProvideInfo.Reset;
            _ReagreeToProvideInfo.SetRange("Send Type", false);
            repeat
                _ReagreeToProvideInfo.SetRange("Source No.", Customer."No.");
                if not _ReagreeToProvideInfo.FindSet then
                    InsertReagreeToProvInfoWithCustomer();
            until Customer.Next = 0;
        end;

        RelationshipFamily.SetRange("Personal Data", true);
        RelationshipFamily.SetFilter("Personal Data Concu. Date", '<>%1&<%2', 0D, _ExpirationDate);
        RelationshipFamily.SetFilter("Reagree Prov. Info Send Date", '<>%1&<%2', 0D, _ExpirationDate);
        if RelationshipFamily.FindSet then begin
            _ReagreeToProvideInfo.Reset;
            _ReagreeToProvideInfo.SetRange("Send Type", false);
            repeat
                _ReagreeToProvideInfo.SetRange("Source No.", RelationshipFamily."Contract No.");
                _ReagreeToProvideInfo.SetRange("Source Line No.", RelationshipFamily."Line No.");
                if not _ReagreeToProvideInfo.FindSet then
                    InsertReagreeToProvInfoWithRelationshipFam();
            until RelationshipFamily.Next = 0;
        end;


        Clear(_CommFun);
        _CommFun.UpdateJobQueueHistoty(5, MSG001);
    end;

    local procedure InsertReagreeToProvInfoWithCustomer()
    var
        _ReagreeToProvideInfo: Record "DK_Reagree To Provide Info";
    begin

        with _ReagreeToProvideInfo do begin
            Init;
            "No." := '';
            Type := Type::Customer;
            "Send Type" := false;
            "Source No." := Customer."No.";
            Name := Customer.Name;
            "Post Code" := Customer."Post Code";
            Address := Customer.Address;
            "Address 2" := Customer."Address 2";
            "Phone No." := Customer."Phone No.";
            "E-mail" := Customer."E-mail";
            "Mobile No." := Customer."Mobile No.";
            "Personal Data" := Customer."Personal Data";
            "Marketing SMS" := Customer."Marketing SMS";
            "Marketing Phone" := Customer."Marketing Phone";
            "Markeing E-mail" := Customer."Marketing E-Mail";
            "Personal Data Third Party" := Customer."Personal Data Third Party";
            "Personal Data Referral" := Customer."Personal Data Referral";
            "Personal Data Concu. Date" := Customer."Personal Data Concu. Date";

            "Creation Base Date" := Today;

            Insert(true);
        end;
    end;

    local procedure InsertReagreeToProvInfoWithRelationshipFam()
    var
        _ReagreeToProvideInfo: Record "DK_Reagree To Provide Info";
    begin

        with _ReagreeToProvideInfo do begin
            Init;
            "No." := '';
            Type := Type::ReleationFam;
            "Send Type" := false;
            "Source No." := RelationshipFamily."Contract No.";
            "Source Line No." := RelationshipFamily."Line No.";
            Name := RelationshipFamily.Name;
            "Post Code" := RelationshipFamily."Post Code";
            Address := RelationshipFamily.Address;
            "Address 2" := RelationshipFamily."Address 2";
            "Phone No." := RelationshipFamily."Phone No.";
            "E-mail" := RelationshipFamily."E-mail";
            "Mobile No." := RelationshipFamily."Mobile No.";
            "Personal Data" := RelationshipFamily."Personal Data";
            "Marketing SMS" := RelationshipFamily."Marketing SMS";
            "Marketing Phone" := RelationshipFamily."Marketing Phone";
            "Markeing E-mail" := RelationshipFamily."Marketing E-Mail";
            "Personal Data Third Party" := RelationshipFamily."Personal Data Third Party";
            "Personal Data Referral" := RelationshipFamily."Personal Data Referral";
            "Personal Data Concu. Date" := RelationshipFamily."Personal Data Concu. Date";

            "Creation Base Date" := Today;

            Insert(true);
        end;
    end;
}

