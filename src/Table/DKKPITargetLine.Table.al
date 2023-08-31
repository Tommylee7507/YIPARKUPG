table 50137 "DK_KPI Target Line"
{
    // 
    // DK34: 20201113
    //   - Create

    Caption = 'KPI Target Line';

    fields
    {
        field(1;"Document No.";Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2;"OBJECT ID";Code[20])
        {
            Caption = 'OBJECT ID';
            DataClassification = ToBeClassified;
        }
        field(3;Year;Integer)
        {
            Caption = 'Year';
            DataClassification = ToBeClassified;
        }
        field(4;Status;Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Release;
        }
        field(5;"Report Taget Value Code";Code[20])
        {
            Caption = 'Report Taget Value Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ReportTargetValue: Record "DK_Report Target Value";
            begin
                if _ReportTargetValue.Get("OBJECT ID","Report Taget Value Code") then
                  "Report Taget Value Name" := _ReportTargetValue.Name
                else
                  "Report Taget Value Name" := '';
            end;
        }
        field(6;"Report Taget Value Name";Text[50])
        {
            Caption = 'Report Taget Value Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                _ReportTargetValue: Record "DK_Report Target Value";
            begin
                Validate("Report Taget Value Code",_ReportTargetValue.GetRepTargetValCode("Report Taget Value Name","OBJECT ID"));
            end;
        }
        field(7;Month;Integer)
        {
            Caption = 'Month';
            DataClassification = ToBeClassified;
            MaxValue = 12;
            MinValue = 0;
        }
        field(8;Amount;Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(5000;"Createtion Date";DateTime)
        {
            Caption = 'Createtion Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5001;"Createtion Person";Code[50])
        {
            Caption = 'Createtion Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5002;"Last Date Modified";DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5003;"Last Modified Person";Code[50])
        {
            Caption = 'Last Modified Person';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Document No.","Report Taget Value Code",Month)
        {
            Clustered = true;
        }
        key(Key2;"Report Taget Value Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        "Createtion Date" := CurrentDateTime;
        "Createtion Person" := UserId;
        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;

    trigger OnModify()
    begin

        "Last Date Modified" := CurrentDateTime;
        "Last Modified Person" := UserId;
    end;
}

