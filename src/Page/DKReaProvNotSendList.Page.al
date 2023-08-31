page 50271 "DK_Rea. Prov. Not Send List"
{
    // 
    // DK34: 20201023
    //   - Create

    Caption = 'Reagree To Provide Information Not Send List';
    CardPageID = "DK_Rea. Prov. Not Send Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Reagree To Provide Info";
    SourceTableView = SORTING("No.")
                      WHERE("Send Type" = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("E-mail"; Rec."E-mail")
                {
                }
                field("Personal Data"; Rec."Personal Data")
                {
                }
                field("Marketing SMS"; Rec."Marketing SMS")
                {
                }
                field("Marketing Phone"; Rec."Marketing Phone")
                {
                }
                field("Markeing E-mail"; Rec."Markeing E-mail")
                {
                }
                field("Personal Data Third Party"; Rec."Personal Data Third Party")
                {
                }
                field("Personal Data Referral"; Rec."Personal Data Referral")
                {
                }
                field("Personal Data Concu. Date"; Rec."Personal Data Concu. Date")
                {
                }
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
            systempart(Control22; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create Reagree")
            {
                Caption = 'Create Reagree';
                Image = NewDocument;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    _ReagreeToProvMgt: Codeunit "DK_Reagree To Prov. Mgt";
                begin

                    if Confirm(MSG001) then
                        _ReagreeToProvMgt.Run;
                end;
            }
            separator(Action29)
            {
            }
            action("Send SMS")
            {
                Caption = 'Send SMS';
                Image = PostSendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    _ReagreeToProvSMSSend: Codeunit "DK_Reagree To Prov. SMS Send";
                begin

                    if Confirm(MSG002) then
                        _ReagreeToProvSMSSend.Run;
                end;
            }
        }
    }

    var
        MSG001: Label 'Do you want to recreate the data? (Today base)';
        MSG002: Label 'Do you want to send SMS? Documents with invalid mobile phone number are excluded.';
}

