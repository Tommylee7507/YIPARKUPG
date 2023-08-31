page 50101 "DK_Korean Road Address Lookup"
{
    // DK_KRADDR1.0
    //   - Create New

    Caption = 'Korean Road Address Lookup';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    ShowFilter = false;
    SourceTable = "DK_Korean Road Address Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(Control28)
            {
                ShowCaption = false;
                grid(Control29)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group("Input Address to find")
                    {
                        Caption = 'Input Address to find';
                        field(Keyword; Keyword)
                        {
                            Caption = 'Keyword';
                            ShowCaption = false;
                            Width = 1000;

                            trigger OnValidate()
                            begin
                                CurrentPage := 1;
                                SearchingKoreanAddress;
                            end;
                        }
                        field(Language; Language)
                        {
                            OptionCaption = 'korean,English';
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                SearchingKoreanAddress;
                            end;
                        }
                        field("Page"; PageText)
                        {
                            Caption = 'page';
                            DrillDown = true;
                            Editable = false;
                            Enabled = false;
                            Lookup = true;
                            Style = Standard;
                            StyleExpr = TRUE;
                            Width = 50;
                        }
                    }
                }
            }
            repeater(Group)
            {
                field(zipNo; Rec.zipNo)
                {
                }
                field(roadAddr; Rec.roadAddr)
                {
                }
                field(jibunAddr; Rec.jibunAddr)
                {
                }
                field(engkorAddr; Rec.engkorAddr)
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(First)
            {
                Caption = 'First Page';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    CurrentPage := 1;

                    SearchingKoreanAddress;
                end;
            }
            action(Previous)
            {
                Caption = 'Previous Page';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if CurrentPage = 1 then exit;

                    CurrentPage -= 1;

                    SearchingKoreanAddress;
                end;
            }
            action(Next)
            {
                Caption = 'Next Page';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    if TotalPage = CurrentPage then exit;

                    CurrentPage += 1;

                    SearchingKoreanAddress;
                end;
            }
            action(Last)
            {
                Caption = 'Last Page';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    CurrentPage := TotalPage;
                    SearchingKoreanAddress;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if KoreanRaodAddressSetup.Get then;

        if not KoreanRaodAddressSetup.Activated then Error(ErrorMsg100);

        Language := KoreanRaodAddressSetup."Default Language";
        CurrentPage := 1;
    end;

    var
        Keyword: Text;
        PageText: Text;
        Goto: Integer;
        CurrentPage: Integer;
        TotalPage: Integer;
        KoreanRaodAddressMgt: Codeunit "DK_Korean Road Address Mgt.";
        Language: Option KOR,ENG;
        KoreanRaodAddressSetup: Record "DK_Korean Road Address Setup";
        ErrorMsg100: Label 'Korean Road Address is not activated. Please contact your administrator.';
        BlankLbl: Label 'TEST';

    local procedure SearchingKoreanAddress()
    begin
        Clear(KoreanRaodAddressMgt);
        // KoreanRaodAddressMgt.SearchingKoreanAddress(Rec, Keyword, CurrentPage, Language, TotalPage, PageText);////zzz
    end;
}

