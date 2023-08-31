table 50012 DK_Vehicle
{
    Caption = 'Vehicle';
    DrillDownPageID = "DK_Vehicle List";
    LookupPageID = "DK_Vehicle List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);

                if "No." <> xRec."No." then begin
                    FunctionSetup.Get;
                    NoSeriesMgt.TestManual(FunctionSetup."Vehicle Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Vehicle No."; Text[30])
        {
            Caption = 'Vehicle No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Vehicle: Record DK_Vehicle;
            begin
                TestField(Status, Status::Open);

                Check_FieldWork;
                Check_Ledger;

                //>>Vehicle No. Check
                if xRec."Vehicle No." <> "Vehicle No." then begin
                    if "Vehicle No." <> '' then begin
                        _Vehicle.Reset;
                        _Vehicle.SetCurrentKey("No.");
                        _Vehicle.SetRange("Vehicle No.", "Vehicle No.");
                        _Vehicle.SetFilter("No.", '<>%1', "No.");
                        if _Vehicle.FindSet then
                            Error(MSG002, _Vehicle."No.");
                    end;
                end;
                //<<Vehicle No. Check
            end;
        }
        field(3; "Purchase Contract No."; Code[20])
        {
            Caption = 'Purchase Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = "DK_Purchase Contract"."No." WHERE(Status = CONST(Contract));

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(4; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(5; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ChangeMasterName: Codeunit "DK_Change Master Name";
            begin
                TestField(Status, Status::Open);

                _ChangeMasterName.UpdateVehicle("No.", Name, xRec.Name);
            end;
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Confirmation,Sale,Exclusion';
            OptionMembers = Open,Confirmation,Sale,Exclusion;

            trigger OnValidate()
            var
                _VehicleHeader: Record "DK_Vehicle Led. Entry Header";
            begin
            end;
        }
        field(7; Handler; Text[30])
        {
            Caption = 'Handler';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(8; Model; Text[30])
        {
            Caption = 'Model';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(9; "Model Year"; Integer)
        {
            BlankZero = true;
            Caption = 'Model Year';
            DataClassification = ToBeClassified;
            MaxValue = 2999;
            MinValue = 1900;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(10; Division; Text[30])
        {
            Caption = 'Division';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(11; "Vehicle Type"; Option)
        {
            Caption = 'Vehicle Type';
            DataClassification = ToBeClassified;
            InitValue = New;
            OptionCaption = 'New,Used,lease,Rent';
            OptionMembers = New,Used,lease,Rent;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);

                if "Vehicle Type" <> xRec."Vehicle Type" then begin

                    if not Confirm(MSG007, false, FieldCaption("Vehicle Type")) then begin
                        "Vehicle Type" := xRec."Vehicle Type";
                        exit;
                    end;

                    Term := Term::"36";
                    "Expiration Date" := 0D;
                    "Monthly Amount" := 0;
                    "Purchase Date" := 0D;
                    "Purchase Price" := 0;
                    "Sale Date" := 0D;
                    "Closed Date" := 0D;
                end;
            end;
        }
        field(12; "Oil Type"; Option)
        {
            Caption = 'Oil Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Diesel,Gasoline';
            OptionMembers = Diesel,Gasoline;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(13; "Purchase Date"; Date)
        {
            Caption = 'Purchase Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if "Sale Date" <> 0D then begin
                    if "Sale Date" < "Purchase Date" then
                        Error(MSG006, FieldCaption("Sale Date"), FieldCaption("Purchase Date"));
                end;
            end;
        }
        field(14; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if ("Vehicle Type" = "Vehicle Type"::lease) or
                  ("Vehicle Type" = "Vehicle Type"::Rent) then begin
                    CalculationDate;
                end;

                if "Inspection Date From" <> 0D then begin
                    if "Inspection Date From" > "Registration Date" then
                        Error(MSG006, FieldCaption("Registration Date"), FieldCaption("Inspection Date From"));
                end;
            end;
        }
        field(15; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = ToBeClassified;
        }
        field(16; Term; Option)
        {
            AutoFormatType = 1;
            Caption = 'Term';
            DataClassification = ToBeClassified;
            OptionCaption = '36Month,48Month';
            OptionMembers = "36","48";

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if "Registration Date" <> 0D then
                    CalculationDate;
            end;
        }
        field(17; "Closed Date"; Date)
        {
            Caption = 'Closed Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Confirmation);
            end;
        }
        field(18; Price; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Price';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(19; "Purchase Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Purchase Price';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(20; "Monthly Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Monthly Amount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(21; "Inspection Date From"; Date)
        {
            Caption = 'Inspection Date From';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Registration Date" <> 0D then begin
                    if "Inspection Date From" > "Registration Date" then
                        Error(MSG006, FieldCaption("Registration Date"), FieldCaption("Inspection Date From"));
                end;

                if "Inspection Date To" <> 0D then begin
                    if "Inspection Date From" > "Inspection Date To" then
                        Error(MSG006, FieldCaption("Inspection Date To"), FieldCaption("Inspection Date From"));
                end;
            end;
        }
        field(22; "Inspection Date To"; Date)
        {
            Caption = 'Inspection Date To';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Inspection Date From" <> 0D then begin
                    if "Inspection Date From" > "Inspection Date To" then
                        Error(MSG006, FieldCaption("Inspection Date To"), FieldCaption("Inspection Date From"));
                end;
            end;
        }
        field(23; Capacity; Text[30])
        {
            Caption = 'Capacity';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(24; "Standard Grade"; Text[30])
        {
            Caption = 'Standard Grade';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(25; Restrictions; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Restriction';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(26; "Special Contract"; Option)
        {
            Caption = 'Special Contract';
            DataClassification = ToBeClassified;
            InitValue = NonJoin;
            OptionCaption = 'Nontarget,NonJoin,Join';
            OptionMembers = Nontarget,NonJoin,Join;

            trigger OnValidate()
            begin

                if "Special Contract" <> xRec."Special Contract" then begin

                    if not Confirm(MSG007, false, FieldCaption("Special Contract")) then begin
                        "Special Contract" := xRec."Special Contract";
                        exit;
                    end;

                    Insurer := '';
                    "Contract Date From" := 0D;
                    "Insurance Date From" := 0D;
                    "Insurance Date To" := 0D;

                end;
            end;
        }
        field(27; Insurer; Text[30])
        {
            Caption = 'Insurer';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Special Contract", "Special Contract"::Join);
            end;
        }
        field(28; "Contract Date From"; Date)
        {
            Caption = 'Contract Date From';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Special Contract", "Special Contract"::Join);
            end;
        }
        field(29; "Insurance Date From"; Date)
        {
            Caption = 'Insurance Date From';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Special Contract", "Special Contract"::Join);
                if "Insurance Date To" <> 0D then begin
                    if "Insurance Date From" > "Insurance Date To" then
                        Error(MSG006, FieldCaption("Insurance Date To"), FieldCaption("Insurance Date From"));
                end;
            end;
        }
        field(30; "Insurance Date To"; Date)
        {
            Caption = 'Insurance Date To';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Special Contract", "Special Contract"::Join);
                if "Insurance Date From" <> 0D then begin
                    if "Insurance Date From" > "Insurance Date To" then
                        Error(MSG006, FieldCaption("Insurance Date To"), FieldCaption("Insurance Date From"));
                end;
            end;
        }
        field(31; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(32; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Vehicle,equipment';
            OptionMembers = Vehicle,equipment;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);

                if Type <> xRec.Type then begin

                    Check_FieldWork;
                    Check_Ledger;

                    if not Confirm(MSG007, false, FieldCaption(Type)) then begin
                        Type := xRec.Type;
                        exit;
                    end;

                    "Vehicle No." := '';
                    "Registration Date" := 0D;
                    "Purchase Contract No." := '';
                    Name := '';
                    Price := 0;
                    "Cost Amount" := 0;
                    Handler := '';
                    Division := '';
                    Model := '';
                    "Model Year" := 0;
                    Capacity := '';
                    "Inspection Date From" := 0D;
                    "Inspection Date To" := 0D;
                    "Standard Grade" := '';
                    Restrictions := 0;
                    Term := Term::"36";
                    "Expiration Date" := 0D;
                    "Monthly Amount" := 0;
                    "Purchase Date" := 0D;
                    "Purchase Price" := 0;
                    Insurer := '';
                    "Contract Date From" := 0D;
                    "Insurance Date From" := 0D;
                    "Insurance Date To" := 0D;
                end;
            end;
        }
        field(33; "Sale Date"; Date)
        {
            Caption = 'Sale Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(Status, Status::Confirmation);
                if "Purchase Date" <> 0D then begin
                    if "Sale Date" < "Purchase Date" then
                        Error(MSG006, FieldCaption("Sale Date"), FieldCaption("Purchase Date"));
                end;
            end;
        }
        field(35; "Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount(Equipment)';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
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
        key(Key2; "Vehicle No.")
        {
        }
        key(Key3; Type)
        {
        }
        key(Key4; Name)
        {
        }
        key(Key5; Handler)
        {
        }
        key(Key6; "Vehicle Type")
        {
        }
        key(Key7; "Oil Type")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Type, "Vehicle No.", Name, Handler, "Vehicle Type", "Oil Type")
        {
        }
    }

    trigger OnDelete()
    begin

        TestField(Status, Status::Open);

        Check_Ledger;
        Check_FieldWork;
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            FunctionSetup.Get;
            FunctionSetup.TestField("Vehicle Nos.");
            NoSeriesMgt.InitSeries(FunctionSetup."Vehicle Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        TestField("No.");

        //Creation Date,Person
        "Creation Date" := CurrentDateTime;
        "Creation Person" := UserId;

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin

        //Modified Date,Person
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId
    end;

    trigger OnRename()
    begin
        Error('');
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FunctionSetup: Record "DK_Function Setup";
        MSG001: Label 'Can not be deleted in %1 state. Change to %2 Status.';
        MSG002: Label '%1 has the same car number.';
        MSG003: Label 'You must select an existing %1.';
        MSG004: Label 'It becomes impossible to modify or delete in use by %1.';
        MSG005: Label 'If you change the %1 to %2, you can not select a %3.\Would you like to continue?';
        MSG006: Label '%1 can not be greater than %2.';
        MSG007: Label 'If you change the %1, related information will be initialized.\Do you want to continue?';
        MSG008: Label 'You can not leave the %1 and %2 blank.';


    procedure AssistEdit(OldVehicle: Record DK_Vehicle): Boolean
    var
        _Vehicle: Record DK_Vehicle;
    begin
        with _Vehicle do begin
            _Vehicle := Rec;

            FunctionSetup.Get;
            FunctionSetup.TestField("Vehicle Nos.");
            if NoSeriesMgt.SelectSeries(FunctionSetup."Vehicle Nos.", OldVehicle."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := _Vehicle;
                exit(true);
            end;
        end;
    end;


    procedure Check_Ledger()
    var
        _VehicleLedEntryHeader: Record "DK_Vehicle Led. Entry Header";
    begin

        _VehicleLedEntryHeader.Reset;
        _VehicleLedEntryHeader.SetRange("Vehicle Document No.", "No.");
        if _VehicleLedEntryHeader.FindFirst then
            Error(MSG004, _VehicleLedEntryHeader.TableCaption);
    end;


    procedure Check_FieldWork()
    var
        _FieldWorkHeader: Record "DK_Field Work Header";
        _FieldWorkLineItem: Record "DK_Field Work Line Item";
    begin
        _FieldWorkLineItem.Reset;
        _FieldWorkLineItem.SetRange("Used Assets Code", "No.");
        if _FieldWorkLineItem.FindSet then begin
            repeat
                _FieldWorkHeader.Reset;
                _FieldWorkHeader.SetRange("No.", _FieldWorkLineItem."Document No.");
                if _FieldWorkHeader.FindSet then
                    Error(MSG004, _FieldWorkHeader.TableCaption);

            until _FieldWorkLineItem.Next = 0;
        end;
    end;


    procedure Check_Vehicle()
    begin
        TestField("Registration Date");
        TestField("Vehicle No.");
        TestField(Name);
        //TESTFIELD(Handler);
        //TESTFIELD(Division);
        case Type of
            Type::Vehicle:
                begin
                    //TESTFIELD(Price);
                    //TESTFIELD(Model);
                    //TESTFIELD("Model Year");
                    //TESTFIELD("Inspection Date From");
                    //TESTFIELD("Inspection Date To");
                    //TESTFIELD(Restrictions);
                end;
            Type::equipment:
                begin
                    // TESTFIELD("Cost Amount");
                end;
        end;

        if "Special Contract" = "Special Contract"::Join then begin
            //TESTFIELD(Insurer);
            //TESTFIELD("Contract Date From");
            //TESTFIELD("Insurance Date From");
            //TESTFIELD("Insurance Date To");
        end;

        case "Vehicle Type" of
            "Vehicle Type"::New, "Vehicle Type"::Used:
                begin
                    //TESTFIELD("Purchase Date");
                    //TESTFIELD("Purchase Price");
                end;
            "Vehicle Type"::lease, "Vehicle Type"::Rent:
                begin
                    //TESTFIELD("Expiration Date");
                    //TESTFIELD("Monthly Amount");
                end;
        end;
    end;


    procedure SetReOpen()
    begin
        //Check_FieldWork;
        //Check_Ledger;

        Status := Rec.Status::Open;
        Modify;
    end;


    procedure SetRelease()
    begin

        Check_Vehicle;

        //"Sale Date" := 0D;
        //"Closed Date" := 0D;

        Status := Rec.Status::Confirmation;
        Modify;
    end;


    procedure SetSales()
    begin
        Check_FieldWork;
        Check_Ledger;

        if ("Sale Date" = 0D) and
          ("Closed Date" = 0D) then begin
            Error(MSG008, FieldCaption("Sale Date"), FieldCaption("Closed Date"));
        end;

        if not Confirm(MSG005, false, FieldCaption(Status), Status::Sale, "No.") then exit;

        Status := Rec.Status::Sale;
        Modify;
    end;


    procedure SetExclusion()
    begin
        Check_FieldWork;
        Check_Ledger;

        if not Confirm(MSG005, false, FieldCaption(Status), Status::Exclusion, "No.") then exit;

        Status := Rec.Status::Exclusion;
        Modify;
    end;

    procedure GetVehicleNo(pVehicleText: Text): Text
    begin
        exit(GetVehicleNoOpenCard(pVehicleText));
    end;

    procedure GetVehicleNoOpenCard(pVehicleText: Text): Code[20]
    var
        _Vehicle: Record DK_Vehicle;
        _VehicleNo: Code[20];
        _VehicleWithoutQuote: Text;
        _VehicleFilterFromStart: Text;
        _VehicleFilterContains: Text;
    begin
        if pVehicleText = '' then
            exit('');

        if StrLen(pVehicleText) <= MaxStrLen(_Vehicle."No.") then
            if _Vehicle.Get(CopyStr(pVehicleText, 1, MaxStrLen(_Vehicle."No."))) then
                exit(_Vehicle."No.");

        //_Vehicle.SETRANGE(Blocked,FALSE);
        _Vehicle.SetRange(Status, _Vehicle.Status::Confirmation);
        _Vehicle.SetRange("Vehicle No.", pVehicleText);
        if _Vehicle.FindFirst then
            exit(_Vehicle."No.");

        _Vehicle.SetCurrentKey("Vehicle No.");

        _VehicleWithoutQuote := ConvertStr(pVehicleText, '''', '?');
        _Vehicle.SetFilter("Vehicle No.", '''@' + _VehicleWithoutQuote + '''');
        if _Vehicle.FindFirst then
            exit(_Vehicle."No.");

        _Vehicle.SetRange("Vehicle No.");

        _VehicleFilterFromStart := '''@' + _VehicleWithoutQuote + '*''';

        _Vehicle.FilterGroup := -1;
        _Vehicle.SetFilter("No.", _VehicleFilterFromStart);
        _Vehicle.SetFilter("Vehicle No.", _VehicleFilterFromStart);

        if _Vehicle.FindFirst then
            exit(_Vehicle."No.");

        _VehicleFilterContains := '''@*' + _VehicleWithoutQuote + '*''';

        _Vehicle.SetFilter("No.", _VehicleFilterContains);
        _Vehicle.SetFilter("Vehicle No.", _VehicleFilterContains);

        if _Vehicle.Count = 1 then begin
            _Vehicle.FindFirst;
            exit(_Vehicle."No.");
        end;

        if not GuiAllowed then
            Error(MSG003, _Vehicle.TableCaption);


        Error(MSG003, _Vehicle.TableCaption);
    end;


    procedure CalculationDate()
    begin
        if Term = Term::"36" then begin
            "Expiration Date" := CalcDate('<+36M>', "Registration Date");
            Modify;
        end else begin
            "Expiration Date" := CalcDate('<+48M>', "Registration Date");
            Modify;
        end;
    end;
}

