page 50034 "DK_External DB Con. Infor."
{
    Caption = 'External DB Connection Information';
    SourceTable = "DK_External DB Con. Infor.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ShowMandatory = true;
                }
                field("DB Type"; Rec."DB Type")
                {
                    ShowMandatory = true;
                }
                field("Server Name"; Rec."Server Name")
                {
                }
                field("DB Name"; Rec."DB Name")
                {
                    ShowMandatory = true;
                }
                field("DB User ID"; Rec."DB User ID")
                {
                    ShowMandatory = true;
                }
                field("DB User PW"; Rec."DB User PW")
                {
                    ShowMandatory = true;
                }
                field("DB Test Conn. Date"; Rec."DB Test Conn. Date")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control2; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Connection Test")
            {
                Caption = 'Connection Test';
                Image = Database;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    _ExternalDBProcess: Codeunit "DK_External DB Process";
                begin
                    ////zzz++
                    // if _ExternalDBProcess.TestConnecting(rec.Code) then begin
                    //     rec."DB Test Conn. Date" := Today;
                    //     Message(MSG001, rec.Description);
                    //     CurrPage.Update;
                    // end;
                    ////zzz--
                end;
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        if (Rec."Server Name" <> xRec."Server Name") or
           (Rec."DB Name" <> xRec."DB Name") or
           (Rec."DB User ID" <> xRec."DB User ID") or
           (Rec."DB User PW" <> xRec."DB User PW") or
           (Rec."DB Type" <> xRec."DB Type") then
            ClearTestDate;
    end;

    var
        MSG001: Label '%1, Connection success!';
        MSG002: Label 'Connection information for %1 %2 DB has changed. Please proceed to re-connect test!';


    procedure ClearTestDate()
    begin
        rec."DB Test Conn. Date" := 0D;
        Message(MSG002, rec.Code, rec.Description);
    end;
}

