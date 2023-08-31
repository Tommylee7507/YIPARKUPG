table 50049 "DK_Purchase Header"
{
    // 
    // DK34: 20201110
    //   - Add Field: Item Type

    Caption = 'Purchase Header';
    DataCaptionFields = "No.";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Rece. Ship. Header Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Release;
        }
        field(4; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(5; "Receipt Time"; Time)
        {
            Caption = 'Receipt Time';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(7; "Purchase Item"; Option)
        {
            Caption = 'Purchase Item';
            DataClassification = ToBeClassified;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;

            trigger OnValidate()
            var
                _PurchaseLine: Record "DK_Purchase Line";
            begin

                if Rec."Purchase Item" <> xRec."Purchase Item" then begin
                    if "Purchase Item" = "Purchase Item"::No then begin
                        _PurchaseLine.Reset;
                        _PurchaseLine.SetRange("Document No.", "No.");
                        _PurchaseLine.FilterGroup := -1;
                        _PurchaseLine.SetFilter("Unit Price", '<>0');
                        _PurchaseLine.SetFilter("Vendor No.", '<>%1', '');
                        if _PurchaseLine.FindFirst then begin
                            if not Confirm(MSG003, false, FieldCaption("Purchase Item"),
                                                            _PurchaseLine.FieldCaption("Unit Price"),
                                                            _PurchaseLine.FieldCaption("Vendor No.")) then begin
                                "Purchase Item" := "Purchase Item"::Yes;
                                exit;
                            end;
                            repeat
                                _PurchaseLine.Validate("Unit Price", 0);
                                _PurchaseLine.Validate("Vendor No.", '');
                                _PurchaseLine.Modify;
                            until _PurchaseLine.Next = 0;
                        end;
                    end;
                end;
            end;
        }
        field(8; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(9; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin

                if _Employee.Get("Employee No.") then
                    "Employee Name" := _Employee.Name
                else
                    "Employee Name" := '';
            end;
        }
        field(10; "Employee Name"; Text[30])
        {
            Caption = 'Employee';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin

                Validate("Employee No.", _Employee.GetEmployeeNo("Employee Name"));
            end;
        }
        field(200; "Item Type"; Option)
        {
            Caption = 'Item Type';
            DataClassification = ToBeClassified;
            Description = 'DK34';
            OptionCaption = 'Consumable,Assets';
            OptionMembers = Consumable,Assets;
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
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Receipt Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Remarks, "Receipt Date", "No. Series")
        {
        }
    }

    trigger OnDelete()
    var
        _PurchaseLine: Record "DK_Purchase Line";
    begin
        TestField(Status, Status::Open);

        _PurchaseLine.Reset;
        _PurchaseLine.SetRange("Document No.", "No.");
        if _PurchaseLine.FindSet then
            _PurchaseLine.DeleteAll(true);
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Rece. Ship. Header Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Rece. Ship. Header Nos.", xRec."No. Series", WorkDate, "No.", "No. Series");
        end;
        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField(Status, Status::Open);

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        Employee: Record DK_Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label 'It is not possible to change it because there is a line with %1.';
        MSG002: Label 'Changes need to be %1.';
        MSG003: Label 'If you change the %1, all the %2 and %3 that are currently specified will be initialized. Do you want to continue?';
        MSG004: Label 'This document has already been %1.';


    procedure AssistEdit(OldRecShipHead: Record "DK_Purchase Header"): Boolean
    var
        _RecShipHeader: Record "DK_Purchase Header";
    begin
        with _RecShipHeader do begin
            _RecShipHeader := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Rece. Ship. Header Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Rece. Ship. Header Nos.", OldRecShipHead."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _RecShipHeader;
                exit(true);
            end;
        end;
    end;


    procedure SetReleased()
    var
        _PurchaseItemPost: Codeunit "DK_Purchase Item - Post";
    begin

        if _PurchaseItemPost.CheckValue(Rec) then begin
            Status := Rec.Status::Release;
            Modify;
        end;
    end;


    procedure SetReOpen()
    begin
        Status := Rec.Status::Open;
        Modify;
    end;


    procedure SetPost(): Boolean
    var
        _PurchaseItemPost: Codeunit "DK_Purchase Item - Post";
    begin

        if Posted then
            Error(MSG004, FieldCaption(Posted));

        if Status = Rec.Status::Release then begin
            _PurchaseItemPost.Post(Rec);
            exit(true)
        end
        else
            Error(MSG002, Status::Release);
    end;
}

