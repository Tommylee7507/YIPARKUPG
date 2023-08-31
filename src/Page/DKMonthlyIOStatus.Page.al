page 50209 "DK_Monthly I/O Status"
{
    Caption = 'Monthly I/O Status';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SourceTable = "DK_Report Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group("Reference Date")
            {
                Caption = 'Reference Date';
                field(YearFilter; YearFilter)
                {
                    Caption = 'YearFilter';
                    MaxValue = 3000;
                    MinValue = 1900;

                    trigger OnValidate()
                    begin
                        YearFilter_Onvalidate;
                    end;
                }
                field(MonthFilter; MonthFilter)
                {
                    Caption = 'Month';
                    MaxValue = 12;
                    MinValue = 0;

                    trigger OnValidate()
                    begin
                        MonthFilter_Onvalidate;
                    end;
                }
            }
            group(Option)
            {
                Caption = 'Option';
                field(cItemMainCode; ItemMainCode)
                {
                    Caption = 'Item Main Code';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _RecItemMainCategory: Record "DK_Item Main Category";
                    begin

                        _RecItemMainCategory.Reset;
                        if PAGE.RunModal(0, _RecItemMainCategory) = ACTION::LookupOK then begin
                            Text := _RecItemMainCategory.Code;
                            exit(true);
                        end else
                            exit(false);
                    end;

                    trigger OnValidate()
                    begin
                        ItemMainCode_Onvalidate;
                    end;
                }
                field(cItemSubCode; ItemSubCode)
                {
                    Caption = 'Item Sub Catgory Code';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _ItemSubCategoryRec: Record "DK_Item Sub Category";
                    begin

                        _ItemSubCategoryRec.Reset;
                        _ItemSubCategoryRec.SetRange("Item Main Cat. Code", ItemMainCode);
                        if PAGE.RunModal(0, _ItemSubCategoryRec) = ACTION::LookupOK then begin
                            Text := _ItemSubCategoryRec.Code;
                            exit(true);
                        end else
                            exit(false);
                    end;

                    trigger OnValidate()
                    var
                        _ItemSubCategory: Record "DK_Item Sub Category";
                    begin
                        ItemSubCode_Onvalidate;
                    end;
                }
                field(cItemCode; ItemCode)
                {
                    Caption = 'Item Code';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _Item: Record DK_Item;
                    begin

                        _Item.Reset;
                        _Item.SetRange("Item Main Cat. Code", ItemMainCode);
                        _Item.SetRange("Item Sub Cat. Code", ItemSubCode);
                        if PAGE.RunModal(0, _Item) = ACTION::LookupOK then begin
                            Text := _Item."No.";
                            exit(true);
                        end else
                            exit(false);
                    end;

                    trigger OnValidate()
                    var
                        _Item: Record DK_Item;
                    begin
                        ItemCode_Onvalidate;
                    end;
                }
            }
            repeater(Group)
            {
                field("SHORT TEXT0"; Rec."SHORT TEXT0")
                {
                    Caption = 'Item Main Category';
                }
                field("SHORT TEXT1"; Rec."SHORT TEXT1")
                {
                    Caption = 'Item Sub Category';
                }
                field(DECIMAL0; Rec.DECIMAL0)
                {
                    Caption = 'Receipt Quantity';
                }
                field(DECIMAL1; Rec.DECIMAL1)
                {
                    Caption = 'Shipment Quantity';
                }
                field(DECIMAL2; Rec.DECIMAL2)
                {
                    Caption = 'Inventory Quantity';
                }
                field(DECIMAL3; Rec.DECIMAL3)
                {
                    Caption = 'Opening Inventory';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Inquiry)
            {
                Caption = 'Inquiry';
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    SetDeleteData;
                    DataInquiry;

                    if Rec.FindFirst then;

                    CurrPage.Update;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

        SetData;
    end;

    var
        YearFilter: Integer;
        MonthFilter: Integer;
        MSG001: Label 'Analyzing Data...\\';
        YearMSG: Label '%1';
        ItemMainCode: Code[20];
        ItemSubCode: Code[20];
        ItemCode: Code[20];
        EntryNo: Integer;
        IOTypeMSG1: Label 'Inventory';
        IOTYpeMSG2: Label 'Receipt';
        IOTypeMSG3: Label 'Shipment';
        MSG002: Label '€Ë‘¹‚Ë……„’ Š±÷…© Œ÷ Ž°„Ÿ„¾.';
        ItemSubCategory: Record "DK_Item Sub Category";
        Item: Record DK_Item;

    local procedure SetDeleteData()
    begin

        Rec.Reset;
        Rec.DeleteAll;
    end;

    local procedure SetData()
    begin

        YearFilter := Date2DMY(WorkDate, 3);
    end;


    procedure DataInquiry()
    var
        _StartDate: Date;
        _EndDate: Date;
        _PreEndDate: Date;
    begin

        Clear(ItemSubCategory);

        if MonthFilter = 0 then begin
            _StartDate := DMY2Date(1, 1, YearFilter);
            _EndDate := WorkDate;
        end else begin
            _StartDate := DMY2Date(1, MonthFilter, YearFilter);
            _EndDate := CalcDate('<CM>', _StartDate);
        end;

        _PreEndDate := _StartDate - 1;

        if ItemCode <> '' then begin
            Item.SetRange("Item Main Cat. Code", ItemMainCode);
            Item.SetRange("Item Sub Cat. Code", ItemSubCode);
            Item.SetRange("No.", ItemCode);
            SetItemCategory(_StartDate, _EndDate, _PreEndDate);
        end else begin
            if ItemSubCode <> '' then begin
                ItemSubCategory.SetRange("Item Main Cat. Code", ItemMainCode);
                ItemSubCategory.SetRange(Code, ItemSubCode);
            end else begin
                if ItemMainCode <> '' then begin
                    ItemSubCategory.SetRange("Item Main Cat. Code", ItemMainCode);
                end else begin
                    ItemSubCategory.SetRange(Blocked);
                end;
            end;

            SetItemSubCategory(_StartDate, _EndDate, _PreEndDate);
        end;
    end;

    local procedure SetItemCategory(pStartDate: Date; pEndDate: Date; pPreEndDate: Date)
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
    begin

        if Item.FindSet then begin
            EntryNo += 1;
            Rec.Init;
            Rec."USER ID" := UserId;
            Rec."OBJECT ID" := PAGE::"DK_Monthly I/O Status";
            Rec."Entry No." := EntryNo;
            Rec."SHORT TEXT0" := Item."Item Main Cat. Name";
            Rec."SHORT TEXT1" := Item."Item Sub Cat. Name";

            _ItemLedgerEntry.Reset;
            _ItemLedgerEntry.SetRange("Item Main Cat. Code", Item."Item Main Cat. Code");
            _ItemLedgerEntry.SetRange("Item Sub Cat. Code", Item."Item Sub Cat. Code");
            _ItemLedgerEntry.SetRange("Item No.", Item."No.");

            _ItemLedgerEntry.SetRange(Date, pStartDate, pEndDate);
            _ItemLedgerEntry.SetRange("Entry Type", _ItemLedgerEntry."Entry Type"::Receipt);
            if _ItemLedgerEntry.FindSet then begin
                _ItemLedgerEntry.CalcSums(Quantity);
                Rec.DECIMAL0 := _ItemLedgerEntry.Quantity;  //¯× Œ÷‡«
            end;
            _ItemLedgerEntry.SetRange("Entry Type", _ItemLedgerEntry."Entry Type"::Shipment);
            if _ItemLedgerEntry.FindSet then begin
                _ItemLedgerEntry.CalcSums(Quantity);
                Rec.DECIMAL1 := _ItemLedgerEntry.Quantity;  //“Ë× Œ÷‡«
            end;
            _ItemLedgerEntry.SetRange(Date, 0D, pEndDate);
            _ItemLedgerEntry.SetRange("Entry Type");
            if _ItemLedgerEntry.FindSet then begin
                _ItemLedgerEntry.CalcSums(Quantity);
                Rec.DECIMAL2 := _ItemLedgerEntry.Quantity;  //Ï× Œ÷‡«
            end;
            _ItemLedgerEntry.SetRange(Date, 0D, pPreEndDate);
            if _ItemLedgerEntry.FindSet then begin
                _ItemLedgerEntry.CalcSums(Quantity);
                Rec.DECIMAL3 := _ItemLedgerEntry.Quantity;  //œõ Ï× Œ÷‡«
            end;
            Rec.Insert;
            ;
        end;
    end;

    local procedure SetItemSubCategory(pStartDate: Date; pEndDate: Date; pPreEndDate: Date)
    var
        _ItemLedgerEntry: Record "DK_Item Ledger Entry";
    begin

        _ItemLedgerEntry.Reset;
        if ItemSubCategory.FindSet then begin
            repeat
                ItemSubCategory.CalcFields("Item Main Cat. Name");

                EntryNo += 1;
                Rec.Init;
                Rec."USER ID" := UserId;
                Rec."OBJECT ID" := PAGE::"DK_Monthly I/O Status";
                Rec."Entry No." := EntryNo;
                Rec."SHORT TEXT0" := ItemSubCategory."Item Main Cat. Name";
                Rec."SHORT TEXT1" := ItemSubCategory.Name;

                _ItemLedgerEntry.SetRange("Item Main Cat. Code", ItemSubCategory."Item Main Cat. Code");
                _ItemLedgerEntry.SetRange("Item Sub Cat. Code", ItemSubCategory.Code);

                _ItemLedgerEntry.SetRange(Date, pStartDate, pEndDate);
                _ItemLedgerEntry.SetRange("Entry Type", _ItemLedgerEntry."Entry Type"::Receipt);
                if _ItemLedgerEntry.FindSet then begin
                    _ItemLedgerEntry.CalcSums(Quantity);
                    Rec.DECIMAL0 := _ItemLedgerEntry.Quantity;  // ¯× Œ÷‡«
                end;
                _ItemLedgerEntry.SetRange("Entry Type", _ItemLedgerEntry."Entry Type"::Shipment);
                if _ItemLedgerEntry.FindSet then begin
                    _ItemLedgerEntry.CalcSums(Quantity);
                    Rec.DECIMAL1 := _ItemLedgerEntry.Quantity;  // “Ë× Œ÷‡«
                end;
                _ItemLedgerEntry.SetRange("Entry Type");
                _ItemLedgerEntry.SetRange(Date, 0D, pEndDate);
                if _ItemLedgerEntry.FindSet then begin
                    _ItemLedgerEntry.CalcSums(Quantity);
                    Rec.DECIMAL2 := _ItemLedgerEntry.Quantity;  // Ï× Œ÷‡«
                end;
                _ItemLedgerEntry.SetRange(Date, 0D, pPreEndDate);
                if _ItemLedgerEntry.FindSet then begin
                    _ItemLedgerEntry.CalcSums(Quantity);
                    Rec.DECIMAL3 := _ItemLedgerEntry.Quantity;  // œõ Ï× Œ÷‡«
                end;
                Rec.Insert;
                ;
            until ItemSubCategory.Next = 0;
        end;
    end;

    local procedure YearFilter_Onvalidate()
    begin

        if YearFilter = 0 then
            Error(MSG002);

        SetDeleteData;
    end;

    local procedure MonthFilter_Onvalidate()
    begin
        SetDeleteData;
    end;

    local procedure ItemMainCode_Onvalidate()
    begin
        SetDeleteData;
    end;

    local procedure ItemSubCode_Onvalidate()
    begin
        SetDeleteData;
    end;

    local procedure ItemCode_Onvalidate()
    begin
        SetDeleteData;
    end;
}

