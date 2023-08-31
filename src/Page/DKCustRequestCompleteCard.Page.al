page 50247 "DK_Cust. Request Complete Card"
{
    Caption = 'Customer Request Complete';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Customer Requests";
    SourceTableView = WHERE(Status = FILTER(Complete | Impossible));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = Rec.Status <> Rec.Status::Complete;
                field("No."; Rec."No.")
                {
                    Importance = Additional;

                    trigger OnAssistEdit()
                    begin
                        //>>Auto No.
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                        //<<Auto No.
                    end;
                }
                field(Title; Rec.Title)
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Importance = Additional;
                }
                field("Employee name"; Rec."Employee name")
                {
                }
                field("Customer Status"; Rec."Customer Status")
                {

                    trigger OnValidate()
                    begin
                        CustomerStatCheck();
                    end;
                }
                field("Process Date"; Rec."Process Date")
                {
                }
                field("Process Content"; Rec."Process Content")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field(Status; Rec.Status)
                {

                    trigger OnValidate()
                    begin
                        ProceesDivCheck();
                    end;
                }
            }
            group("Customer Information")
            {
                Caption = 'Customer Information';
                Visible = CustomerVisible;
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Main Customer No."; Rec."Main Customer No.")
                {
                    Importance = Additional;
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Cust. Mobile No."; Rec."Cust. Mobile No.")
                {
                }
                field("Cust. Phone No."; Rec."Cust. Phone No.")
                {
                }
                field("Cust. E-mail"; Rec."Cust. E-mail")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Importance = Additional;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
            }
            group("Receipt Information")
            {
                Caption = 'Receipt Information';
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field("Field Work Sub Cat. Code"; Rec."Field Work Sub Cat. Code")
                {
                    Importance = Additional;
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
                field("Receipt Contents"; Rec."Receipt Contents")
                {
                }
                field("Work Cemetery Code"; Rec."Work Cemetery Code")
                {
                    Importance = Additional;
                }
                field("Work Cemetery No."; Rec."Work Cemetery No.")
                {
                }
                field("Receipt Method"; Rec."Receipt Method")
                {
                }
                field("Receipt Division"; Rec."Receipt Division")
                {
                }
                field("Work Division"; Rec."Work Division")
                {
                }
            }
            group("Applicant Information")
            {
                Caption = 'Applicant Information';
                field("Per. Info. Aggreement"; Rec."Per. Info. Aggreement")
                {
                }
                field("Appl. Name"; Rec."Appl. Name")
                {
                }
                field("Appl. Mobile No."; Rec."Appl. Mobile No.")
                {
                }
                field("Appl. Phone No."; Rec."Appl. Phone No.")
                {
                }
                field("Email Status"; Rec."Email Status")
                {
                }
                field("Appl. E-mail"; Rec."Appl. E-mail")
                {
                    Enabled = Rec."Email Status" = FALSE;
                }
                field("Relationship With Cust."; Rec."Relationship With Cust.")
                {
                }
            }
            group("Field Work Information")
            {
                Caption = 'Field Work Information';
                Editable = false;
                field("Feedback Date"; Rec."Feedback Date")
                {
                }
                field("Work Time Spent"; Rec."Work Time Spent")
                {
                }
                field("Work Manager Code"; Rec."Work Manager Code")
                {
                    Importance = Additional;
                }
                field("Work Manager"; Rec."Work Manager")
                {
                }
                field("Work Group Code"; Rec."Work Group Code")
                {
                    Importance = Additional;
                }
                field("Work Group"; Rec."Work Group")
                {
                }
                field("Work Personnel"; Rec."Work Personnel")
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
            systempart(Control4; Notes)
            {
            }
        }
    }

    actions
    {
    }

    var
        CustomerVisible: Boolean;
        PostEnable: Boolean;
        ImposibleEnable: Boolean;
        MSG001: Label 'Would you like to include customer information in applicant information?';
        MSG002: Label 'The %1 has been Rec. Modify to a %2.';
        MSG003: Label 'It''s already %1.';


    procedure ProceesDivCheck()
    begin
        //Status Check
        if Rec.Status <> Rec.Status::Complete then begin
            case Rec.Status of
                Rec.Status::Open:
                    begin
                        PostEnable := true;
                        ImposibleEnable := true;
                    end;
                Rec.Status::Post:
                    begin
                        PostEnable := false;
                        ImposibleEnable := true;
                    end;
                Rec.Status::Complete:
                    begin
                        ImposibleEnable := false;
                        PostEnable := false;
                    end;
                Rec.Status::Impossible:
                    begin
                        PostEnable := false;
                        ImposibleEnable := false;
                    end;
            end;
        end;
    end;


    procedure CustomerStatCheck()
    begin
        if Rec."Customer Status" = Rec."Customer Status"::Customer then
            CustomerVisible := true
        else
            CustomerVisible := false;
    end;
}

