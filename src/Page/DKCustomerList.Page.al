page 50008 "DK_Customer List"
{
    // 
    // #2194: 20201005
    //   - Add Action: Change Loge Entry
    // 
    // DK34 : 20201021
    //   - Add Field: "Request Del", "Request DateTime", "Request Person"
    //   - Add Var: DelAll
    //   - Add Text: MSG001
    //   - Add Action: Action38
    //   - Rec. Modify Trigger: OnOpenPage()
    //      : 20201026
    //   - Add Field: "Reagree Prov. Info Send Date"
    //      : 20201027
    //   - Add Action: <Page DK_Rea. Prov. Send List>

    Caption = 'Customer List';
    CardPageID = "DK_Customer Card";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Customer;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field("E-mail"; Rec."E-mail")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                    Visible = false;
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Company Post Code"; Rec."Company Post Code")
                {
                }
                field("Company Address"; Rec."Company Address")
                {
                }
                field("Company Address 2"; Rec."Company Address 2")
                {
                }
                field("Create Organizer"; Rec."Create Organizer")
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
                field("Marketing E-Mail"; Rec."Marketing E-Mail")
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
                field("Reagree Prov. Info Send Date"; Rec."Reagree Prov. Info Send Date")
                {
                }
                field("Request Del"; Rec."Request Del")
                {
                }
                field("Request DateTime"; Rec."Request DateTime")
                {
                }
                field("Request Person"; Rec."Request Person")
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
            systempart(Control17; Notes)
            {
            }
            part(Control42; "DK_Cust Contract factBox")
            {
                SubPageLink = "Customer No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Change History")
            {
                Caption = 'Change History';
                Image = History;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "DK_Changed Customer History";
                RunPageLink = "No." = FIELD("No.");
            }
            action(Contracts)
            {
                Caption = 'Contracts';
                Image = OpportunitiesList;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.ShowContractList(Rec."No.");
                end;
            }
            separator("#2194")
            {
                Caption = '#2194';
            }
            action("Change Loge Entry")
            {
                Caption = 'Change Loge Entry';
                Image = ChangeLog;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _ChangeLogEntry: Record "Change Log Entry";
                    _DK_ChangeLogEntry: Page "DK_Change Log Entry";
                begin

                    _ChangeLogEntry.Reset;
                    _ChangeLogEntry.FilterGroup(2);
                    _ChangeLogEntry.SetRange("Table No.", 50008);
                    _ChangeLogEntry.SetRange("Type of Change", _ChangeLogEntry."Type of Change"::Modification);
                    _ChangeLogEntry.FilterGroup(0);
                    _ChangeLogEntry.SetRange("Primary Key Field 1 Value", Rec."No.");
                    _ChangeLogEntry.SetRange("Field No.", 2);

                    Clear(_DK_ChangeLogEntry);
                    _DK_ChangeLogEntry.SetRecord(_ChangeLogEntry);
                    _DK_ChangeLogEntry.SetTableView(_ChangeLogEntry);
                    _DK_ChangeLogEntry.Run;
                end;
            }
            separator(DK34)
            {
                Caption = 'DK34';
            }
            action("Request Delete All")
            {
                Caption = 'Request Delete All';
                Enabled = DelAll;
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Process;
                Visible = DelAll;

                trigger OnAction()
                var
                    _UserSetup: Record "User Setup";
                    _Customer: Record DK_Customer;
                begin

                    _UserSetup.Reset;
                    _UserSetup.SetRange("User ID", UserId);
                    _UserSetup.SetRange("DK_Customer Admin.", true);
                    if not _UserSetup.FindSet then
                        exit;


                    _Customer.Reset;
                    _Customer.SetRange("Request Del", true);
                    if _Customer.FindSet then begin

                        if Confirm(MSG001, false) then
                            _Customer.DeleteAll(true);

                    end;
                end;
            }
            action("Reagree Provide To Information List")
            {
                Caption = 'Reagree Provide To Information List';
                Ellipsis = true;
                Image = ShowList;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page "DK_Rea. Prov. Send List";
                RunPageLink = "Source No." = FIELD("No.");
            }
        }
    }

    trigger OnOpenPage()
    var
        _UserSetup: Record "User Setup";
    begin

        //DK34
        //Delete All Action
        _UserSetup.Reset;
        _UserSetup.SetRange("User ID", UserId);
        _UserSetup.SetRange("DK_Pay. Posting Admin.", true);
        if _UserSetup.FindSet then
            DelAll := true
        else
            DelAll := false;
    end;

    var
        DelAll: Boolean;
        MSG001: Label 'Do you really want to delete it?';
}

