page 50290 "DK_CRM Sales Type (Web)"
{
    Caption = 'CRM Sales Type (Web)';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_CRM Sales Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Seq; Rec.Seq)
                {
                }
                field(Name; NewName)
                {
                    Caption = 'Name';

                    trigger OnValidate()
                    begin
                        Rec.Name := CopyStr(NewName, 1, 50);
                    end;
                }
                field(Indicator; NewIndicator)
                {
                    Caption = 'Indicator';

                    trigger OnValidate()
                    begin
                        Rec.Indicator := CopyStr(NewIndicator, 1, 50);
                    end;
                }
                field(P_Item; P_Item)
                {
                    Caption = 'Item';

                    trigger OnValidate()
                    begin

                        case P_Item of
                            '100000002':
                                Rec.Item := Rec.Item::Sales;           //ˆ•“Ë
                            '100000012':
                                Rec.Item := Rec.Item::Job;             //Žð‰½‚Œ€
                            '100000001':
                                Rec.Item := Rec.Item::Purchase;        //€ˆˆ•
                            '100000010':
                                Rec.Item := Rec.Item::Project;         //—‘‡ž‘º–«
                            '100000011':
                                Rec.Item := Rec.Item::PDS;             //PDS
                            '100000008':
                                Rec.Item := Rec.Item::IT;              //ý‹Ó
                            '100000007':
                                Rec.Item := Rec.Item::Director;        //®‘ð°
                            '100000005':
                                Rec.Item := Rec.Item::Budget;          //‰‹Ó
                            '100000000':
                                Rec.Item := Rec.Item::CS;              //×„ˆˆ‘‡
                            '100000004':
                                Rec.Item := Rec.Item::Design;          //Œ‚Ð
                            '100000006':
                                Rec.Item := Rec.Item::Licensing;       //ž—Ìí
                            '100000003':
                                Rec.Item := Rec.Item::Cemetery;        //‰ª°‘†ŒŠ
                            '100000009':
                                Rec.Item := Rec.Item::Landscape;       //‘†µ
                            '100000013':
                                Rec.Item := Rec.Item::Architecture;    //—“Ê
                            '100000099':
                                Rec.Item := Rec.Item::Etc;             //€Ë•ˆ
                            else
                                Error(MSG001, P_Item);
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        P_Item: Text[20];
        MSG001: Label 'This Item is not defined. Please contact your administrator. Value: Rec.%1';
        NewName: Text[300];
        NewIndicator: Text[300];
}

