page 50046 "DK_Relationship Family List"
{
    // 
    // DK34: 20201026
    //   - Add Field: "Personal Data","Marketing SMS","Marketing Phone","Marketing E-Mail","Personal Data Third Party","Personal Data Referral",
    //           "Personal Data Concu. Date","Reagree Prov. Info Send Date"
    //     : 20201027
    //   - Add Action: <Page DK_Rea. Prov. Send List>

    Caption = 'Relationship Family';
    CardPageID = "DK_Relationship Family";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Relationship Family";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No."; Rec."Contract No.")
                {
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Supervise No."; Rec."Supervise No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                    Editable = false;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field(Name; Rec.Name)
                {
                    ShowMandatory = true;
                }
                field(Relationship; Rec.Relationship)
                {
                    ShowMandatory = true;
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field(Address; Rec.Address)
                {
                    ShowMandatory = true;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ShowMandatory = true;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ShowMandatory = true;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ShowMandatory = true;
                }
                field("E-mail"; Rec."E-mail")
                {
                }
                field(Remark; Rec.Remark)
                {
                }
                field(Used; Rec.Used)
                {
                }
                field("Last Access Date"; Rec."Last Access Date")
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
                field("Creation Date"; Rec."Creation Date")
                {
                    Visible = false;
                }
                field("Creation Person"; Rec."Creation Person")
                {
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                }
                field("Last Modified Person"; Rec."Last Modified Person")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control23; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Reagree Provide To Information List")
            {
                Caption = 'Reagree Provide To Information List';
                Ellipsis = true;
                Image = ShowList;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page "DK_Rea. Prov. Send List";
                RunPageLink = "Source No." = FIELD("Contract No."),
                              "Source Line No." = FIELD("Line No.");
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Validate("Contract No.", ContractNo);
        Rec.Validate("Supervise No.", SuperviseNo);
        Rec.Validate("Cemetery Code", CemeteryNo);
    end;

    var
        ContractNo: Code[20];
        SuperviseNo: Code[20];
        CemeteryNo: Code[20];


    procedure SetParameter(var pContractNo: Code[20]; var pSuperviseNo: Code[20]; var pCemeteryNo: Code[20])
    begin
        ContractNo := pContractNo;
        SuperviseNo := pSuperviseNo;
        CemeteryNo := pCemeteryNo;
    end;
}

