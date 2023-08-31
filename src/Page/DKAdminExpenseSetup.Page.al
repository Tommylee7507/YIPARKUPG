page 50007 "DK_Admin. Expense Setup"
{
    // //í¦Š»µ“ ß‘ª ‰‘ñ ‰«Œ¡— »˜€Ëú Žð…Ñœ–« ‘°—Ê

    Caption = 'Administrative Expense Setup';
    DelayedInsert = true;
    PageType = Worksheet;
    ShowFilter = false;
    SourceTable = "DK_Admin. Expense Price";
    SourceTableView = SORTING("Price Type", "Unit Price Type Code", "Starting Date");

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Visible = NOT IsOnMobile;
                field(PriceTypeFilter; PriceTypeFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Price Type Filter';
                    OptionCaption = 'Maintenance Cost,Landscape Architecture';

                    trigger OnValidate()
                    begin
                        PriceTypeFilterOnAfterValidate;
                    end;
                }
                field(UnitPriceTypeCtrl; UnitPriceTypeFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Unit Price Type Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _UnitPriceType: Record "DK_Unit Price Type";
                    begin

                        _UnitPriceType.Reset;
                        if PAGE.RunModal(0, _UnitPriceType) = ACTION::LookupOK then begin
                            Text := _UnitPriceType.Code;
                            exit(true);
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        UnitPriceTypeFilterOnAfterValidate;
                    end;
                }
                field(StartingDateFilter; StartingDateFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Starting Date Filter';

                    trigger OnValidate()
                    var
                        TextManagement: Codeunit TextManagement;
                    begin
                        TextManagement.MakeDateFilter(StartingDateFilter);
                        StartingDateFilterOnAfterValid;
                    end;
                }
            }
            repeater(Group)
            {
                field("Price Type"; Rec."Price Type")
                {
                    Visible = false;
                }
                field("Unit Price Type Code"; Rec."Unit Price Type Code")
                {
                    Visible = false;
                }
                field("Unit Price Type Name"; Rec."Unit Price Type Name")
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Show Payment Expect")
            {
                Caption = 'Show Payment Expect';
                Image = PrepaymentInvoice;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    _PaymentExpect: Codeunit "DK_Payment Expect";
                begin

                    Clear(_PaymentExpect);
                    _PaymentExpect.ShowPaymentExpectDoc(Rec);
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("Unit Price Type Code");
        Rec.TestField("Starting Date");

        //ß‘ª ‰‘ñ ‘ˆÏ ˜«ž
        CheckPayExpectDoc_ExpirationDate;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.TestField("Unit Price Type Code");
        Rec.TestField("Starting Date");

        //ß‘ª ‰‘ñ ‘ˆÏ ˜«ž
        CheckPayExpectDoc_ExpirationDate;
    end;

    trigger OnOpenPage()
    begin
        IsOnMobile := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone;
        PriceTypeFilter := PriceTypeFilter::Maintenance;
        SetRecFilters;
    end;

    var
        PriceTypeFilter: Option Maintenance,"Land. Arc.";
        UnitPriceTypeFilter: Text;
        StartingDateFilter: Text[30];
        ClientTypeManagement: Codeunit ClientTypeManagement;
        IsOnMobile: Boolean;

    local procedure StartingDateFilterOnAfterValid()
    begin
        CurrPage.SaveRecord;
        SetRecFilters;
    end;

    local procedure PriceTypeFilterOnAfterValidate()
    begin
        CurrPage.SaveRecord;
        SetRecFilters;
    end;

    local procedure UnitPriceTypeFilterOnAfterValidate()
    begin
        CurrPage.SaveRecord;
        SetRecFilters;
    end;

    procedure SetRecFilters()
    begin
        //SalesCodeFilterCtrlEnable := TRUE;

        Rec.SetRange("Price Type", PriceTypeFilter);

        if UnitPriceTypeFilter <> '' then
            Rec.SetFilter("Unit Price Type Code", UnitPriceTypeFilter)
        else
            Rec.SetRange("Unit Price Type Code");

        if StartingDateFilter <> '' then
            Rec.SetFilter("Starting Date", StartingDateFilter)
        else
            Rec.SetRange("Starting Date");

        CurrPage.Update(false);
    end;

    local procedure CheckPayExpectDoc_ExpirationDate()
    var
        _PaymentExpect: Codeunit "DK_Payment Expect";
    begin

        Clear(_PaymentExpect);

        _PaymentExpect.CheckAdminExpensToPayExpectDoc(Rec);
    end;
}

