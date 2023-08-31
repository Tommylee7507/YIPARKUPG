report 50001 "DK_Create Publish Admin. Ex."
{
    // *DK32 : 20200715
    //   - Modify Function : Batch
    //   - Add Function : InsertPublishAdminExpDocLine

    Caption = 'Create Publish Admin. Expense';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DocumentNo; DocumentNo)
                {
                    Caption = 'Document No.';
                    Editable = false;
                }
                field(BaseDate; BaseDate)
                {
                    Caption = 'Base Date';
                    Editable = false;
                }
                field(FromDate; FromDate)
                {
                    Caption = 'From Date';
                }
                field(ToDate; ToDate)
                {
                    Caption = 'To Date';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            BaseDate := WorkDate;

            FunctionSetup.Get;
            FunctionSetup.TestField("Admin. Expense Target");
            //FunctionSetup.TESTFIELD("Admin. Expense Due Period");
            FromDate := CalcDate(StrSubstNo('<%1-CM>', FunctionSetup."Admin. Expense Target"), BaseDate);
            ToDate := CalcDate(StrSubstNo('<%1+CM>', FunctionSetup."Admin. Expense Target"), BaseDate);
            PaymentDueDate := CalcDate(StrSubstNo('<%1>', FunctionSetup."Admin. Expense Due Period"), BaseDate);
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Batch;
    end;

    var
        BaseDate: Date;
        FromDate: Date;
        ToDate: Date;
        PaymentDueDate: Date;
        FunctionSetup: Record "DK_Function Setup";
        DocumentNo: Code[20];
        MSG001: Label 'Payment Due Date must be specified.';
        MSG002: Label 'From Date must be specified.';
        MSG003: Label 'To Date must be specified.';
        MSG004: Label 'Target does not exist. Period : %1 ~ %2';
        AdminExpLedger: Record "DK_Admin. Expense Ledger";
        MSG005: Label 'Aggregate for %1 to %2 Periods';
        MSG006: Label 'An already created document exists. %1:%2';


    procedure SetPrameter(pDocumentNo: Code[20])
    begin

        DocumentNo := pDocumentNo;
    end;

    local procedure Batch()
    var
        _Contract: Record DK_Contract;
        _PublishAdminExpDoc: Record "DK_Publish Admin. Expense Doc.";
        _NewLine: Integer;
        _AdminExpenseMgt: Codeunit "DK_Admin. Expense Mgt.";
    begin

        if FromDate = 0D then Error(MSG002);
        if ToDate = 0D then Error(MSG003);
        if PaymentDueDate = 0D then Error(MSG001);
        //IF DocumentNo = '' THEN ;

        _PublishAdminExpDoc.Reset;
        _PublishAdminExpDoc.SetFilter("Document No.", '<>%1', DocumentNo);
        _PublishAdminExpDoc.SetRange("From Date", FromDate);
        _PublishAdminExpDoc.SetRange("To Date", ToDate);
        if _PublishAdminExpDoc.FindSet then
            Error(MSG006,
                      _PublishAdminExpDoc.FieldCaption("Document No."),
                      _PublishAdminExpDoc."Document No.",
                      FromDate,
                      ToDate);


        _PublishAdminExpDoc.Reset;
        _PublishAdminExpDoc.SetRange("Document No.", DocumentNo);
        if _PublishAdminExpDoc.FindSet then begin
            _PublishAdminExpDoc."From Date" := FromDate;
            _PublishAdminExpDoc."To Date" := ToDate;
            _PublishAdminExpDoc.Description := StrSubstNo(MSG005, FromDate, ToDate);
            _PublishAdminExpDoc.Modify(true);
        end;

        //Ÿ‰¦ ÐŽÊ—
        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::General);
        _Contract.SetRange(Status, _Contract.Status::FullPayment);
        _Contract.SetRange("General Expiration Date", FromDate, ToDate);
        if _Contract.FindFirst then begin
            repeat
                InsertPublishAdminExpDocLine(_NewLine, DocumentNo, _Contract); //DK32

            until _Contract.Next = 0;
        end;

        //€¸‡Õ ÐŽÊí €¸‡Õ„Ï “‹€ˆ—Ÿ„’ µÕ
        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::Group);
        _Contract.SetRange("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Group");
        _Contract.SetRange(Status, _Contract.Status::FullPayment);
        _Contract.SetRange("General Expiration Date", FromDate, ToDate);
        if _Contract.FindFirst then begin
            repeat
                InsertPublishAdminExpDocLine(_NewLine, DocumentNo, _Contract);//DK32

            until _Contract.Next = 0;
        end;

        //€¸‡Õ ÐŽÊí ÐŽÊ„Ï “‹€ˆ—Ÿ„’ µÕ
        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::Sub);
        _Contract.SetRange("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
        _Contract.SetRange(Status, _Contract.Status::FullPayment);
        _Contract.SetRange("General Expiration Date", FromDate, ToDate);
        if _Contract.FindFirst then begin
            repeat

                InsertPublishAdminExpDocLine(_NewLine, DocumentNo, _Contract);//DK32

            until _Contract.Next = 0;
        end;


        //===============================================================================
        //>>DK32
        //Ž–‚šŠ•µ - ÐŽÊ—Ÿ× 10‚Ë ˜” “´“š ýˆ«Š± ‰È‹²— ‘†˜ˆ!!!!!!!!

        //Ÿ‰¦ ÐŽÊ—
        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::General);
        _Contract.SetRange(Status, _Contract.Status::FullPayment);
        _Contract.SetRange("General Expiration Date", 0D);
        _Contract.SetRange("Admin. Exp. Start Date", FromDate, ToDate);
        if _Contract.FindFirst then begin
            repeat

                InsertPublishAdminExpDocLine(_NewLine, DocumentNo, _Contract);//DK32

            until _Contract.Next = 0;
        end;

        //€¸‡Õ ÐŽÊí €¸‡Õ„Ï “‹€ˆ—Ÿ„’ µÕ
        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::Group);
        _Contract.SetRange("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Group");
        _Contract.SetRange(Status, _Contract.Status::FullPayment);
        _Contract.SetRange("General Expiration Date", 0D);
        _Contract.SetRange("Admin. Exp. Start Date", FromDate, ToDate);
        if _Contract.FindFirst then begin
            repeat

                InsertPublishAdminExpDocLine(_NewLine, DocumentNo, _Contract);//DK32

            until _Contract.Next = 0;
        end;

        //€¸‡Õ ÐŽÊí ÐŽÊ„Ï “‹€ˆ—Ÿ„’ µÕ
        _Contract.Reset;
        _Contract.SetRange("Contract Type", _Contract."Contract Type"::Sub);
        _Contract.SetRange("Admin. Expense Option", _Contract."Admin. Expense Option"::"Per Contract");
        _Contract.SetRange(Status, _Contract.Status::FullPayment);
        _Contract.SetRange("General Expiration Date", 0D);
        _Contract.SetRange("Admin. Exp. Start Date", FromDate, ToDate);
        if _Contract.FindFirst then begin
            repeat

                InsertPublishAdminExpDocLine(_NewLine, DocumentNo, _Contract);//DK32

            until _Contract.Next = 0;
        end;
        //<<DK32

        if _NewLine = 0 then
            Error(MSG004, FromDate, ToDate);
    end;

    local procedure InsertPublishAdminExpDocLine(var pNewLineNo: Integer; pDocumentNo: Code[20]; pContract: Record DK_Contract)
    var
        _PublishAdminExpDocLine: Record "DK_Publish Admin. Exp. Doc. Li";
    begin
        //>>DK32

        pNewLineNo += 10000;

        _PublishAdminExpDocLine.Init;
        _PublishAdminExpDocLine."Document No." := pDocumentNo;
        _PublishAdminExpDocLine."Line No." := pNewLineNo;
        _PublishAdminExpDocLine.Validate("Contract No.", pContract."No.");
        _PublishAdminExpDocLine.System := true;
        _PublishAdminExpDocLine.Insert(true);

        //<<DK32
    end;
}

