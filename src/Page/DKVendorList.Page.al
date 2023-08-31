page 50024 "DK_Vendor List"////zzz
{
    Caption = 'Vendor List';
    CardPageID = "DK_Vendor Card";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DK_Vendor;

    // layout
    // {
    //     area(content)
    //     {
    //         repeater(Group)
    //         {
    //             field("No."; Rec."No.")
    //             {
    //             }
    //             field(Name; Rec.Name)
    //             {
    //             }
    //             field(Blocked; Rec.Blocked)
    //             {
    //             }
    //             field("VAT Registration No."; Rec."VAT Registration No.")
    //             {
    //             }
    //             field(Contact; Rec.Contact)
    //             {
    //             }
    //             field("Phone No."; Rec."Phone No.")
    //             {
    //             }
    //             field("Fax No."; Rec."Fax No.")
    //             {
    //             }
    //             field("Post Code"; Rec."Post Code")
    //             {
    //             }
    //             field(Address; Rec.Address)
    //             {
    //             }
    //             field("Address 2"; Rec."Address 2")
    //             {
    //             }
    //             field("E-mail"; Rec."E-mail")
    //             {
    //             }
    //             field("Employee No."; Rec."Employee No.")
    //             {
    //             }
    //             field("Employee Name"; Rec."Employee Name")
    //             {
    //             }
    //             field(Remarks; Rec.Remarks)
    //             {
    //             }
    //         }
    //     }
    //     area(factboxes)
    //     {
    //         part(Control19; Rec."DK_Attched Files Factbox")
    //         {
    //             SubPageLink = "Table ID" = CONST(50022),
    //                           "Source No." = FIELD("No."),
    //                           "Source Line No." = CONST(0);
    //         }
    //         systempart(Control7; Notes)
    //         {
    //         }
    //     }
    // }

    // actions
    // {
    // }
}

