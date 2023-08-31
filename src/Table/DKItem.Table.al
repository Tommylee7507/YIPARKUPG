table 50010 DK_Item
{
    Caption = 'Item';
    DataCaptionFields = "No.", Name, "Item Main Cat. Name", "Item Sub Cat. Name";
    DrillDownPageID = "DK_Item List";
    LookupPageID = "DK_Item List";

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
                    NoSeriesMgt.TestManual(FunctionSetup."Item Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Check_Inventory;
            end;
        }
        field(3; "Item Main Cat. Code"; Code[20])
        {
            Caption = 'Item Main Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Item Main Category";

            trigger OnValidate()
            var
                _ItemMainCategory: Record "DK_Item Main Category";
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin
                //CALCFIELDS("Item Main Cat.Name");
                //"Item Main Cat.Name" := _ItemMainCatRec.GetItemMName("Item Main Cat.Code");
                if _ItemMainCategory.Get("Item Main Cat. Code") then
                    "Item Main Cat. Name" := _ItemMainCategory.Name
                else
                    "Item Main Cat. Name" := '';

                Validate("Item Sub Cat. Code", '');

                _ChangeMasterName.UpdateItem("No.", Name, xRec.Name);
            end;
        }
        field(4; "Item Main Cat. Name"; Text[30])
        {
            Caption = 'Item Main Category Name';
            TableRelation = "DK_Item Main Category";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Item Main Cat. Code", ItemMainCategory.GetItemMCode("Item Main Cat. Name"));
            end;
        }
        field(5; "Item Sub Cat. Code"; Code[20])
        {
            Caption = 'Item Sub Category Code';
            TableRelation = "DK_Item Sub Category".Code WHERE("Item Main Cat. Code" = FIELD("Item Main Cat. Code"));

            trigger OnValidate()
            var
                _ItemSubCategory: Record "DK_Item Sub Category";
            begin
                if _ItemSubCategory.Get("Item Main Cat. Code", "Item Sub Cat. Code") then
                    "Item Sub Cat. Name" := _ItemSubCategory.Name
                else
                    "Item Sub Cat. Name" := '';
            end;
        }
        field(6; "Item Sub Cat. Name"; Text[30])
        {
            Caption = 'Item Sub Category Name';
            TableRelation = "DK_Item Sub Category".Code WHERE("Item Main Cat. Code" = FIELD("Item Main Cat. Code"));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Item Sub Cat. Code", ItemSubCategory.GetItemSCode("Item Sub Cat. Name", "Item Main Cat. Code"));
            end;
        }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin
                if _Employee.Get("Employee No.") then
                    "Employee Name" := _Employee.Name;
            end;
        }
        field(11; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            TableRelation = DK_Employee;

            trigger OnValidate()
            begin
                Validate("Employee No.", Employee.GetEmployeeNo("Employee Name"));
            end;
        }
        field(12; Price; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Price';
            DataClassification = ToBeClassified;
        }
        field(13; "QR Code Use"; Option)
        {
            Caption = 'QR Code Use';
            DataClassification = ToBeClassified;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;

            trigger OnValidate()
            begin
                Check_Inventory;
            end;
        }
        field(14; "Notice No."; Code[20])
        {
            Caption = 'Notice No.';
            DataClassification = ToBeClassified;
        }
        field(15; "Notice Use"; Option)
        {
            Caption = 'Notice Use';
            DataClassification = ToBeClassified;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;

            trigger OnValidate()
            begin
                Check_Inventory;
            end;
        }
        field(16; "Notice Quantity"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Notice Quantity';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Check_Inventory;
            end;
        }
        field(17; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Check_Inventory;
            end;
        }
        field(18; Inventory; Decimal)
        {
            CalcFormula = Sum("DK_Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No.")));
            Caption = 'Inventory';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; Remark; Text[100])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
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
        field(59000; idx; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Name)
        {
        }
        key(Key3; "Item Main Cat. Code")
        {
        }
        key(Key4; "Item Main Cat. Name")
        {
        }
        key(Key5; "Item Sub Cat. Code")
        {
        }
        key(Key6; "Item Sub Cat. Name")
        {
        }
        key(Key7; "Employee No.")
        {
        }
        key(Key8; "QR Code Use")
        {
        }
        key(Key9; "Notice Use")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "Item Main Cat. Name", "Item Sub Cat. Name", "QR Code Use")
        {
        }
    }

    trigger OnDelete()
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
        _PostPurchReceipt: Record "DK_Posted Purchase Receipt";
    begin

        _ItemLedgerEntry.Reset;
        _ItemLedgerEntry.SetRange("Item No.", "No.");
        _ItemLedgerEntry.SetRange(Reverse, false);
        if _ItemLedgerEntry.FindSet then
            Error(MSG003);

        _PostPurchReceipt.Reset;
        _PostPurchReceipt.SetRange("Item No.", "No.");
        _PostPurchReceipt.SetRange(Reverse, false);
        if _PostPurchReceipt.FindSet then
            Error(MSG003);
    end;

    trigger OnInsert()
    var
        _DepartmentBoard: Record "DK_Department Board";
    begin
        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Item Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Item Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        TestField("No.");

        if UserId <> 'ADMIN' then
            _DepartmentBoard.Check_EmployeeUserID(UserId);

        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin
        TestField("No.");

        //InventoryCheck();

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    var
        _ItemMainCatRec: Record "DK_Item Main Category";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        Employee: Record DK_Employee;
        ItemMainCategory: Record "DK_Item Main Category";
        Vendor: Record DK_Vendor;
        ItemSubCategory: Record "DK_Item Sub Category";
        MSG001: Label '%1 remain in %2, so it can not be changed.';
        MSG002: Label 'You must select an existing %1.';
        MSG003: Label 'Receiving or canceling records exist. Please cancel the record and try again.';


    procedure AssistEdit(OldItem: Record DK_Item): Boolean
    var
        _Item: Record DK_Item;
    begin
        with _Item do begin
            _Item := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Item Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Item Nos.", OldItem."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _Item;
                exit(true);
            end;
        end;
    end;

    local procedure Check_Inventory()
    begin
        CalcFields(Inventory);
        if Inventory <> 0 then
            Error(MSG001, Name, FieldCaption(Inventory));
    end;

    procedure GetItemNo(pItemText: Text): Text
    begin
        exit(GetItemNoOpenCard(pItemText));
    end;

    procedure GetItemNoOpenCard(pItemText: Text): Code[20]
    var
        _Item: Record DK_Item;
        _ItemNo: Code[20];
        _ItemWithoutQuote: Text;
        _ItemFilterFromStart: Text;
        _ItemFilterContains: Text;
    begin
        if pItemText = '' then
            exit('');

        if StrLen(pItemText) <= MaxStrLen(_Item."No.") then
            if _Item.Get(CopyStr(pItemText, 1, MaxStrLen(_Item."No."))) then
                exit(_Item."No.");

        _Item.SetRange(Blocked, false);
        _Item.SetRange(Name, pItemText);
        if _Item.FindFirst then
            exit(_Item."No.");

        _Item.SetCurrentKey(Name);

        _ItemWithoutQuote := ConvertStr(pItemText, '''', '?');
        _Item.SetFilter(Name, '''@' + _ItemWithoutQuote + '''');
        if _Item.FindFirst then
            exit(_Item."No.");

        _Item.SetRange(Name);

        _ItemFilterFromStart := '''@' + _ItemWithoutQuote + '*''';

        _Item.FilterGroup := -1;
        _Item.SetFilter("No.", _ItemFilterFromStart);
        _Item.SetFilter(Name, _ItemFilterFromStart);

        if _Item.FindFirst then
            exit(_Item."No.");

        _ItemFilterContains := '''@*' + _ItemWithoutQuote + '*''';

        _Item.SetFilter("No.", _ItemFilterContains);
        _Item.SetFilter(Name, _ItemFilterContains);

        if _Item.Count = 1 then begin
            _Item.FindFirst;
            exit(_Item."No.");
        end;

        if not GuiAllowed then
            Error(MSG002, _Item.TableCaption);


        Error(MSG002, _Item.TableCaption);
    end;
}

