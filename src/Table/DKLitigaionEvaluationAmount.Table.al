table 50095 "DK_Litigaion Evaluation Amount"
{
    // 
    // *»‘÷ŠˆŒ÷ ‰°˜ú: #2005 :2020-07-09
    //   - Add field: Bond Type
    // 
    // #2152: 2020-09-07
    //   - Add field: Elapsed Amount

    Caption = 'Litigaion Evaluation Amount';

    fields
    {
        field(1;Date;Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(2;"Litigation Evaluation";Option)
        {
            Caption = 'Litigation Evaluation';
            DataClassification = ToBeClassified;
            Description = '#3202';
            OptionCaption = 'A-Regular,B-Lastyear,C-Regected,D-Unknown,E-Self,F-Solomon';
            OptionMembers = A,B,C,D,E,F;
        }
        field(3;TotalCount;Decimal)
        {
            AutoFormatType = 1;
            Caption = 'TotalCount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(4;TotalSize;Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Size';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(5;"Non-Pay. Admin Exp. Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Non-Pay. Admin Exp. Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(6;"Admin Exp. Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Admin Exp. Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(11;"Litigation Employee No.";Code[20])
        {
            Caption = 'Litigation Employee No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _Employee: Record DK_Employee;
            begin

                _Employee.Reset;
                _Employee.SetRange("No.", "Litigation Employee No.");
                if _Employee.FindSet then
                  "Litigation Employee Name" := _Employee.Name
                else
                  "Litigation Employee Name" := '';
            end;
        }
        field(12;"Litigation Employee Name";Text[30])
        {
            Caption = 'Litigation Employee Name';
            DataClassification = ToBeClassified;
        }
        field(13;"Admin. Expense Type";Option)
        {
            Caption = 'Admin. Expense  Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Landscape Architecture';
            OptionMembers = General,Landscape;
        }
        field(14;"Bond Type";Option)
        {
            Caption = 'Bond Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Shorterm,Longterm';
            OptionMembers = Shortterm,Longterm;
        }
        field(15;"Elapsed Amount";Decimal)
        {
            Caption = 'Elapsed amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1;Date,"Admin. Expense Type","Litigation Employee No.","Litigation Evaluation")
        {
            Clustered = true;
        }
        key(Key2;"Litigation Evaluation")
        {
        }
        key(Key3;TotalCount)
        {
        }
        key(Key4;"Non-Pay. Admin Exp. Amount")
        {
        }
        key(Key5;"Litigation Employee No.")
        {
        }
        key(Key6;"Litigation Employee Name")
        {
        }
        key(Key7;"Admin. Expense Type")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;Date,"Litigation Evaluation",TotalCount,"Non-Pay. Admin Exp. Amount")
        {
        }
    }
}

