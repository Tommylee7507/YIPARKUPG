page 50182 "DK_Sended SMS History Card"
{
    Caption = 'Sended SMS History Card';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Sended SMS History";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Control10)
                {
                    ShowCaption = false;
                    field("Entry No."; Rec."Entry No.")
                    {
                    }
                    field(Status; Rec.Status)
                    {
                    }
                    field("Result Status Code"; Rec."Result Status Code")
                    {
                        Visible = false;
                    }
                    field("Result Status"; Rec."Result Status")
                    {
                        AssistEdit = false;
                        DrillDown = false;
                        Lookup = false;
                    }
                    field("Sending Date"; Rec."Sending Date")
                    {
                    }
                    field("Sending Time"; Rec."Sending Time")
                    {
                    }
                    field("From Phone No."; Rec."From Phone No.")
                    {
                    }
                    field("To Phone No."; Rec."To Phone No.")
                    {
                    }
                    field("Auto Sending"; Rec."Auto Sending")
                    {
                    }
                    field("Source Type"; Rec."Source Type")
                    {
                    }
                    field("Source No."; Rec."Source No.")
                    {
                    }
                    field("Source Line No."; Rec."Source Line No.")
                    {
                    }
                }
                group(Control12)
                {
                    ShowCaption = false;
                    field(Subject; Rec.Subject)
                    {
                    }
                    group(Message)
                    {
                        Caption = 'Message';
                        field("Short Message"; Rec."Short Message")
                        {
                            Editable = false;
                            MultiLine = true;
                            ShowCaption = false;

                            trigger OnValidate()
                            var
                                _CommonFunction: Codeunit "DK_Common Function";
                            begin
                            end;
                        }
                    }
                }
            }
            group(Image)
            {
                Caption = 'Image';
                group(Control26)
                {
                    ShowCaption = false;
                    field(Image1; Rec.Image1)
                    {
                    }
                    field(Image2; Rec.Image2)
                    {
                    }
                    field(Image3; Rec.Image3)
                    {
                    }
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

    var
        WorkMessage: Text;
}

