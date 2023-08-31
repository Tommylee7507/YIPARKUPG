table 50059 "DK_Dev. Target Line"
{
    // 
    // #2107 - 2020-08-18
    //   - Modify Trigger: Contract No. - OnValidate

    Caption = 'Development Target Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Contract;

            trigger OnValidate()
            var
                _Contract: Record DK_Contract;
            begin
                if xRec."Contract No." <> "Contract No." then begin

                    if CheckDetail then begin
                        CalcFields("Cemetery No.");

                        Error(MSG001, "Contract No.",
                                  FieldCaption("Cemetery No."), "Cemetery No.");
                    end;

                    if "Contract No." <> '' then
                        CheckDuplicateContractNo("Document No.", "Line No.", "Contract No.");

                    if _Contract.Get("Contract No.") then begin
                        // >> #2107
                        // _Contract.CALCFIELDS("Customer Name 2", "Customer Name 3");
                        // <<
                        Validate("Supervise No.", _Contract."Supervise No.");
                        Validate("Cemetery Code", _Contract."Cemetery Code");
                        "Main Customer No." := _Contract."Main Customer No.";
                        "Main Customer Name" := _Contract."Main Customer Name";
                        "Customer No. 2" := _Contract."Customer No. 2";
                        "Customer Name 2" := _Contract."Customer Name 2";
                        "Customer No. 3" := _Contract."Customer No. 3";
                        "Customer Name 3" := _Contract."Customer Name 3";
                    end else begin
                        Validate("Supervise No.", '');
                        Validate("Cemetery Code", '');
                        "Main Customer No." := '';
                        "Main Customer Name" := '';
                        "Customer No. 2" := '';
                        "Customer Name 2" := '';
                        "Customer No. 3" := '';
                        "Customer Name 3" := '';
                    end;
                end;
            end;
        }
        field(4; "Supervise No."; Code[20])
        {
            Caption = 'Supervise No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Cemetery Code"; Code[20])
        {
            Caption = 'Cemetery Code';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                CalcFields("Cemetery No.");
            end;
        }
        field(6; "Cemetery No."; Text[20])
        {
            CalcFormula = Lookup(DK_Cemetery."Cemetery No." WHERE("Cemetery Code" = FIELD("Cemetery Code")));
            Caption = 'Cemetery No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Remark; Text[250])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
        field(8; "No. of Detail"; Integer)
        {
            CalcFormula = Count("DK_Counsel History" WHERE("Contract No." = FIELD("Contract No."),
                                                            Type = CONST(General),
                                                            "Dev. Target Doc. No." = FIELD("Document No."),
                                                            "Dev. Target Doc. Line No." = FIELD("Line No.")));
            Caption = 'No. of Detail';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                _CounselHistory: Record "DK_Counsel History";
                _CounselGeneralList: Page "DK_Counsel General List";
            begin
                CalcFields("No. of Detail");
                if "No. of Detail" <> 0 then begin
                    _CounselHistory.Reset;
                    _CounselHistory.FilterGroup(2);
                    _CounselHistory.SetRange("Contract No.", "Contract No.");
                    _CounselHistory.SetRange(Type, _CounselHistory.Type::General);
                    _CounselHistory.SetRange("Dev. Target Doc. No.", "Document No.");
                    _CounselHistory.SetRange("Dev. Target Doc. Line No.", "Line No.");
                    _CounselHistory.FilterGroup(0);
                    if _CounselHistory.FindSet then begin
                        Clear(_CounselGeneralList);
                        _CounselGeneralList.LookupMode(true);
                        _CounselGeneralList.SetTableView(_CounselHistory);
                        _CounselGeneralList.SetRecord(_CounselHistory);
                        _CounselGeneralList.RunModal;
                    end;
                end;
            end;
        }
        field(9; "Main Customer No."; Code[20])
        {
            Caption = 'Main Customer No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Customer;
        }
        field(10; "Main Customer Name"; Text[50])
        {
            Caption = 'Main Customer Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Customer No. 2"; Code[20])
        {
            Caption = 'Customer No. 2';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Customer;
        }
        field(12; "Customer Name 2"; Text[50])
        {
            Caption = 'Customer Name 2';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Customer No. 3"; Code[20])
        {
            Caption = 'Customer No. 3';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = DK_Customer;
        }
        field(14; "Customer Name 3"; Text[50])
        {
            Caption = 'Customer Name 3';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5000; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5001; "Creation Person"; Code[50])
        {
            Caption = 'Creation Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5002; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5003; "Last Modified Person"; Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        _CounselHistory: Record "DK_Counsel History";
    begin
        HeaderDateModify;

        if "Line No." <> 0 then begin
            _CounselHistory.Reset;
            _CounselHistory.SetRange(Type, _CounselHistory.Type::General);
            _CounselHistory.SetRange("Dev. Target Doc. No.", "Document No.");
            _CounselHistory.SetRange("Dev. Target Doc. Line No.", "Line No.");
            if _CounselHistory.FindFirst then
                _CounselHistory.DeleteAll(true);
        end;
    end;

    trigger OnInsert()
    begin
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
        HeaderDateModify;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
        HeaderDateModify;
    end;

    var
        MSG001: Label 'Details exists and can not be modified %1. %2:%3';
        MSG002: Label '%1 can not be specified as Duplicates. Current Value : %2';

    local procedure CheckDetail(): Boolean
    var
        _CounselHistory: Record "DK_Counsel History";
    begin

        if "Line No." <> 0 then begin
            _CounselHistory.Reset;
            _CounselHistory.SetRange(Type, _CounselHistory.Type::General);
            _CounselHistory.SetRange("Dev. Target Doc. No.", "Document No.");
            _CounselHistory.SetRange("Dev. Target Doc. Line No.", "Line No.");
            if _CounselHistory.FindFirst then
                exit(true);
        end;
    end;

    local procedure CheckDuplicateContractNo(pDocNo: Code[20]; pLineNo: Integer; pContarctNo: Code[20])
    var
        _DevTargetLine: Record "DK_Dev. Target Line";
    begin

        if pContarctNo = '' then exit;

        _DevTargetLine.Reset;
        _DevTargetLine.SetRange("Document No.", pDocNo);
        _DevTargetLine.SetFilter("Line No.", '<>%1', pLineNo);
        _DevTargetLine.SetRange("Contract No.", pContarctNo);
        if _DevTargetLine.FindFirst then
            Error(MSG002, _DevTargetLine.FieldCaption("Contract No."), pContarctNo);
    end;

    procedure SelectMultipleContracts()
    var
        _ContractListPage: Page "DK_Contract List";
        _SelectionFilter: Text;
    begin
        //// _SelectionFilter := _ContractListPage.SelectActiveContracts;
        if _SelectionFilter <> '' then
            AddContracts(_SelectionFilter);
    end;

    local procedure AddContracts(SelectionFilter: Text)
    var
        _Contract: Record DK_Contract;
        _DevTargetLine: Record "DK_Dev. Target Line";
        _DevTargetLine2: Record "DK_Dev. Target Line";
    begin
        InitNewLine(_DevTargetLine);
        _Contract.SetFilter("No.", SelectionFilter);
        if _Contract.FindSet then
            repeat

                ///////DuplicateContractNo
                _DevTargetLine2.Reset;
                _DevTargetLine2.SetRange("Document No.", _DevTargetLine."Document No.");
                _DevTargetLine2.SetRange("Contract No.", _Contract."No.");
                if not _DevTargetLine2.FindFirst then begin
                    _DevTargetLine.Init;
                    _DevTargetLine."Line No." += 10000;
                    _DevTargetLine.Validate("Contract No.", _Contract."No.");
                    _DevTargetLine.Insert(true);
                end;
            until _Contract.Next = 0;
    end;

    local procedure InitNewLine(var pNewDevTargetLine: Record "DK_Dev. Target Line")
    var
        _DevTargetLine: Record "DK_Dev. Target Line";
    begin
        pNewDevTargetLine.Copy(Rec);

        _DevTargetLine.SetRange("Document No.", pNewDevTargetLine."Document No.");
        if _DevTargetLine.FindLast then
            pNewDevTargetLine."Line No." := _DevTargetLine."Line No."
        else
            pNewDevTargetLine."Line No." := 0;
    end;


    procedure HeaderDateModify()
    var
        _DevTargerHdr: Record "DK_Dev. Target Header";
    begin

        _DevTargerHdr.Reset;
        _DevTargerHdr.SetRange("No.", "Document No.");
        if _DevTargerHdr.FindSet then begin
            _DevTargerHdr."Last Date Modified" := CurrentDateTime;
            _DevTargerHdr."Last Modified Person" := UserId;
            _DevTargerHdr.Modify;
        end;
    end;
}

