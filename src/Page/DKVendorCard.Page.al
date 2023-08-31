page 50025 "DK_Vendor Card"////zzz
{
    Caption = 'Vendor Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = DK_Vendor;

    // layout
    // {
    //     area(content)
    //     {
    //         group(General)
    //         {
    //             Caption = 'General';
    //             field("No."; Rec."No.")
    //             {
    //                 Importance = Additional;

    //                 trigger OnAssistEdit()
    //                 begin

    //                     if Rec.AssistEdit(xRec) then
    //                         CurrPage.Update;
    //                 end;
    //             }
    //             field(Name; Rec.Name)
    //             {
    //                 ShowMandatory = true;
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

    //                 trigger OnAssistEdit()
    //                 begin
    //                     Rec.AddressLookup();
    //                 end;
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
    //                 Importance = Additional;
    //             }
    //             field("Employee Name"; Rec."Employee Name")
    //             {
    //             }
    //             field(Remarks; Rec.Remarks)
    //             {
    //             }
    //             field(Blocked; Rec.Blocked)
    //             {
    //             }
    //         }
    //         group(Bank)
    //         {
    //             Caption = 'Bank';
    //             field("Bank Code"; Rec."Bank Code")
    //             {
    //                 Importance = Additional;
    //                 ShowMandatory = true;
    //             }
    //             field("Bank Name"; Rec."Bank Name")
    //             {
    //                 Caption = 'Bank';
    //             }
    //             field("Bank Account No."; Rec."Bank Account No.")
    //             {
    //             }
    //             field("Account Holder"; Rec."Account Holder")
    //             {
    //             }
    //         }
    //         group(Information)
    //         {
    //             Caption = 'Information';
    //             field("Creation Date"; Rec."Creation Date")
    //             {
    //             }
    //             field("Creation Person"; Rec."Creation Person")
    //             {
    //             }
    //             field("Last Date Modified"; Rec."Last Date Modified")
    //             {
    //             }
    //             field("Last Modified Person"; Rec."Last Modified Person")
    //             {
    //             }
    //         }
    //     }
    //     area(factboxes)
    //     {
    //         part(Control29; Rec."DK_Attched Files Factbox")
    //         {
    //             SubPageLink = "Table ID"=CONST(50022),
    //                           "Source No."=FIELD("No."),
    //                           "Source Line No."=CONST(0);
    //         }
    //         systempart(Control7;Notes)
    //         {
    //         }
    //     }
    // }

    // actions
    // {
    // }

    // local procedure AddressLookup()
    // var
    //     _DK_KoreanRoadAddrMgt: Codeunit "DK_Korean Road Address Mgt.";
    //     _TmpCode: Code[20];
    //     _TmpText: Text[50];
    // begin

    //     Clear(_DK_KoreanRoadAddrMgt);


    //     _DK_KoreanRoadAddrMgt.SearchKoreanRoadAddress(Address,"Address 2","Post Code",_TmpText,_TmpCode);
    // end;
}

