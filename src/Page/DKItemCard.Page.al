page 50065 "DK_Item Card"
{
    Caption = 'Item Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = DK_Item;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {

                    trigger OnAssistEdit()
                    begin
                        //>>Auto No.
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                        //<<Auto No.
                    end;
                }
                group(Control27)
                {
                    ShowCaption = false;
                    field("Item Main Cat. Code"; Rec."Item Main Cat. Code")
                    {
                        Importance = Additional;
                    }
                    field("Item Main Cat. Name"; Rec."Item Main Cat. Name")
                    {
                        ShowMandatory = true;
                    }
                    field("Item Sub Cat. Code"; Rec."Item Sub Cat. Code")
                    {
                        Importance = Additional;
                    }
                    field("Item Sub Cat. Name"; Rec."Item Sub Cat. Name")
                    {
                        ShowMandatory = true;
                    }
                }
                field(Name; Rec.Name)
                {
                }
                field(Price; Rec.Price)
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Importance = Additional;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Remark; Rec.Remark)
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
            }
            group("Notice Information")
            {
                Caption = 'Notice Information';
                field("Notice No."; Rec."Notice No.")
                {
                    Importance = Additional;
                }
                field("Notice Use"; Rec."Notice Use")
                {

                    trigger OnValidate()
                    begin
                        if Rec."Notice Use" <> xRec."Notice Use" then
                            NoticeUseCheck();
                    end;
                }
                field("Notice Quantity"; Rec."Notice Quantity")
                {
                    Enabled = NoticeEnable;
                }
                field("QR Code Use"; Rec."QR Code Use")
                {
                }
                field(Inventory; Rec.Inventory)
                {
                }
            }
            group(Information)
            {
                Caption = 'Information';
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Creation Person"; Rec."Creation Person")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control24; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        NoticeUseCheck();
    end;

    trigger OnAfterGetRecord()
    begin
        NoticeUseCheck();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _Employee: Record DK_Employee;
    begin
        Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));
    end;

    var
        NoticeEnable: Boolean;


    procedure NoticeUseCheck()
    begin
        if Rec."Notice Use" = Rec."Notice Use"::Yes then
            NoticeEnable := true
        else
            NoticeEnable := false;
    end;
}

