page 50270 "DK_Customer Delete Card"
{
    // 
    // *DK34 : 20201021
    //   - Create

    Caption = 'Customer Delete Card';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "DK_Customer Delete Log";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Control3)
                {
                    ShowCaption = false;
                    field("No."; Rec."No.")
                    {
                    }
                    field(Name; Rec.Name)
                    {
                    }
                    field(Type; Rec.Type)
                    {
                    }
                }
                group(Control7)
                {
                    ShowCaption = false;
                    field(Memo; Rec.Memo)
                    {
                        MultiLine = true;
                    }
                }
            }
            group(Contact)
            {
                Caption = 'Contact';
                field("Mobile No."; Rec."Mobile No.")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("E-mail"; Rec."E-mail")
                {
                }
                group(Control13)
                {
                    ShowCaption = false;
                    field("Address Unkonwn"; Rec."Address Unkonwn")
                    {
                    }
                    field("Post Code"; Rec."Post Code")
                    {

                        trigger OnAssistEdit()
                        begin
                            AddressLookup;
                        end;
                    }
                    field(Address; Rec.Address)
                    {
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                    }
                }
            }
            group("Individual Information")
            {
                Caption = 'Individual Information';
                Editable = Rec.Type = Rec.type::Individual;
                Visible = Rec.Type = Rec.type::Individual;
                field(SSN; SSN)
                {
                    Caption = 'Social Security No.';

                    trigger OnDrillDown()
                    begin
                        SSN := Rec.GetSSNSSNCalculated;
                    end;
                }
                field(Birthday; Rec.Birthday)
                {
                }
                field(Gender; Rec.Gender)
                {
                }
            }
            group("Agreement on Personal Information")
            {
                Caption = 'Agreement on Personal Information';
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
            }
            group("Corporation Information")
            {
                Caption = 'Corporation Information';
                Editable = Rec.Type <> Rec.type::Individual;
                Visible = Rec.Type <> Rec.type::Individual;
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                }
            }
            group("Company Information")
            {
                Caption = 'Company Information';
                Visible = CompVisible;
                group(Control31)
                {
                    ShowCaption = false;
                    field("Company Post Code"; Rec."Company Post Code")
                    {

                        trigger OnAssistEdit()
                        begin
                            CompAddressLookup;
                        end;
                    }
                    field("Company Address"; Rec."Company Address")
                    {
                    }
                    field("Company Address 2"; Rec."Company Address 2")
                    {
                    }
                }
            }
            group("Delete Info")
            {
                Caption = 'Delete Info';
                field("Request DateTime"; Rec."Request DateTime")
                {
                }
                field("Request Person"; Rec."Request Person")
                {
                }
                field("Delete DateTime"; Rec."Delete DateTime")
                {
                }
                field("Delete Person"; Rec."Delete Person")
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
            systempart(Control41; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        ActivateFields;
    end;

    trigger OnAfterGetRecord()
    begin
        ActivateFields;
        SSN := Rec.GetSSN;
    end;

    var
        SocialSecurityNo: Text[20];
        CompVisible: Boolean;
        SSN: Text;
        RecDel: Boolean;

    local procedure ActivateFields()
    begin
        CompVisible := (Rec.Type = Rec.Type::Corporation);
    end;

    local procedure AddressLookup()
    var
        _DK_KoreanRoadAddrMgt: Codeunit "DK_Korean Road Address Mgt.";
        _TmpCode: Code[20];
        _TmpText: Text[50];
    begin

        Clear(_DK_KoreanRoadAddrMgt);
        // _DK_KoreanRoadAddrMgt.SearchKoreanRoadAddress(Rec.Address, Rec."Address 2", Rec."Post Code", _TmpText, _TmpCode);////zzz
    end;

    local procedure CompAddressLookup()
    var
        _DK_KoreanRoadAddrMgt: Codeunit "DK_Korean Road Address Mgt.";
        _TmpCode: Code[20];
        _TmpText: Text[50];
    begin

        Clear(_DK_KoreanRoadAddrMgt);
        // _DK_KoreanRoadAddrMgt.SearchKoreanRoadAddress(Rec."Company Address", Rec."Company Address 2", Rec."Company Post Code", _TmpText, _TmpCode);////zzz
    end;
}

