page 50093 "DK_Upload Cemetery"
{
    Caption = 'Upload Cemetery';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Upload Cemetery Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    StyleExpr = ErrorStyle;
                    Visible = false;
                }
                field("Data Validation"; Rec."Data Validation")
                {
                    StyleExpr = ErrorStyle;
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                    StyleExpr = ErrorStyle;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _Cemetery: Record DK_Cemetery;
                        _CemeteryList: Page "DK_Cemetery List";
                    begin

                        if Rec."Cemetery No." <> '' then begin
                            _Cemetery.Reset;
                            _Cemetery.SetRange("Cemetery No.", Rec."Cemetery No.");

                            Clear(_CemeteryList);
                            _CemeteryList.LookupMode(true);
                            _CemeteryList.SetTableView(_Cemetery);
                            _CemeteryList.SetRecord(_Cemetery);
                            _CemeteryList.RunModal;
                        end;
                    end;
                }
                field("Estate Name"; Rec."Estate Name")
                {
                    StyleExpr = ErrorStyle;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _Estate: Record DK_Estate;
                    begin
                        _Estate.Reset;
                        _Estate.SetRange(Blocked, false);
                        if PAGE.RunModal(0, _Estate) = ACTION::LookupOK then begin
                            Text := _Estate.Name;
                            exit(true);
                        end;
                    end;
                }
                field("Cemetery Conf. Name"; Rec."Cemetery Conf. Name")
                {
                    StyleExpr = ErrorStyle;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _CemeteryConfor: Record "DK_Cemetery Conformation";
                    begin
                        _CemeteryConfor.Reset;
                        if PAGE.RunModal(0, _CemeteryConfor) = ACTION::LookupOK then begin
                            Text := _CemeteryConfor.Name;
                            exit(true);
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        //IF xRec."Cemetery Conf. Name" <> "Cemetery Conf. Name" THEN
                        //  "Cemetery Dig. Name" := '';

                    end;
                }
                field("Cemetery Option Name"; Rec."Cemetery Option Name")
                {
                    StyleExpr = ErrorStyle;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _CemeteryOption: Record "DK_Cemetery Option";
                    begin
                        _CemeteryOption.Reset;
                        if PAGE.RunModal(0, _CemeteryOption) = ACTION::LookupOK then begin
                            Text := _CemeteryOption.Name;
                            exit(true);
                        end;
                    end;
                }
                field("Unit Price Type Name"; Rec."Unit Price Type Name")
                {
                    StyleExpr = ErrorStyle;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _UnitPriceType: Record "DK_Unit Price Type";
                    begin
                        _UnitPriceType.Reset;
                        if PAGE.RunModal(0, _UnitPriceType) = ACTION::LookupOK then begin
                            Text := _UnitPriceType.Name;
                            exit(true);
                        end;
                    end;
                }
                field("Cemetery Dig. Name"; Rec."Cemetery Dig. Name")
                {
                    StyleExpr = ErrorStyle;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _CemeteryDigits: Record "DK_Cemetery Digits";
                    begin
                        if Rec."Cemetery Conf. Name" = '' then
                            Error(MSG001, Rec.FieldCaption("Cemetery Conf. Name"));

                        _CemeteryDigits.Reset;
                        _CemeteryDigits.SetRange("Cemetery Conf. Name", Rec."Cemetery Conf. Name");
                        ;
                        if PAGE.RunModal(0, _CemeteryDigits) = ACTION::LookupOK then begin
                            Text := _CemeteryDigits.Name;
                            exit(true);
                        end;
                    end;
                }
                field(Class; Rec.Class)
                {
                    StyleExpr = ErrorStyle;
                }
                field(Size; Rec.Size)
                {
                    StyleExpr = ErrorStyle;
                }
                field("Size 2"; Rec."Size 2")
                {
                    StyleExpr = ErrorStyle;
                }
                field("Corpse Size"; Rec."Corpse Size")
                {
                    StyleExpr = ErrorStyle;
                }
                field("Landscape Architecture"; Rec."Landscape Architecture")
                {
                    StyleExpr = ErrorStyle;
                }
                field("Position Row"; Rec."Position Row")
                {
                    StyleExpr = ErrorStyle;
                }
                field("Position Column"; Rec."Position Column")
                {
                    StyleExpr = ErrorStyle;
                }
                field(Stone; Rec.Stone)
                {
                    StyleExpr = ErrorStyle;
                }
                field("Tree Type Name"; Rec."Tree Type Name")
                {
                    StyleExpr = ErrorStyle;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        _TreeType: Record "DK_Tree Type";
                    begin
                        _TreeType.Reset;
                        if PAGE.RunModal(0, _TreeType) = ACTION::LookupOK then begin
                            Text := _TreeType.Name;
                            exit(true);
                        end;
                    end;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    StyleExpr = ErrorStyle;
                    Visible = false;
                }
                field("Creation Person"; Rec."Creation Person")
                {
                    StyleExpr = ErrorStyle;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control24; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("New Cemetery")
            {
                Caption = 'New Cemetery';
                Image = CreateDocuments;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    _UploadCemetery: Codeunit "DK_Upload Cemetery";
                begin
                    Clear(_UploadCemetery);
                    if _UploadCemetery.CreateCemetery then begin

                        CurrPage.Update;
                    end;
                end;
            }
            action("Checked Error")
            {
                Caption = 'Checked Error';
                Image = PrevErrorMessage;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F3';

                trigger OnAction()
                var
                    _ErrorMessage: Page "DK_Error Message";
                    _ErrorList: array[100] of Text[250];
                    _ErrorIndex: Integer;
                    _UploadCemetery: Codeunit "DK_Upload Cemetery";
                begin

                    if Rec."Entry No." <> 0 then begin
                        Clear(_ErrorIndex);

                        //Error List Lookup!
                        Clear(_UploadCemetery);
                        _ErrorIndex := _UploadCemetery.ErrorList(Rec, _ErrorList);

                        if _ErrorIndex > 0 then begin
                            Clear(_ErrorMessage);
                            _ErrorMessage.LookupMode(true);
                            _ErrorMessage.SetErrorData(_ErrorIndex, _ErrorList);
                            _ErrorMessage.RunModal;
                        end;
                    end;
                end;
            }
            group(Action26)
            {
                action(UnitPrice)
                {
                    Caption = 'Unit Price';
                    Image = Price;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        _CemeteryUnitPrice: Page "DK_Cemetery Unit Price";
                        _RecCemeteryUnitPrice: Record "DK_Cemetery Unit Price";
                    begin

                        _RecCemeteryUnitPrice.Reset;
                        _RecCemeteryUnitPrice.SetRange("Estate Name", Rec."Estate Name");
                        _RecCemeteryUnitPrice.SetRange("Cemetery Conf. Name", Rec."Cemetery Conf. Name");
                        _RecCemeteryUnitPrice.SetRange("Cemetery Option Name", Rec."Cemetery Option Name");
                        _RecCemeteryUnitPrice.SetFilter("Starting Date", '<=%1', Today);

                        Clear(_CemeteryUnitPrice);
                        _CemeteryUnitPrice.LookupMode(true);
                        _CemeteryUnitPrice.SetTableView(_RecCemeteryUnitPrice);
                        _CemeteryUnitPrice.SetRecord(_RecCemeteryUnitPrice);
                        _CemeteryUnitPrice.RunModal;
                    end;
                }
                action("Cemetery List")
                {
                    Caption = 'Cemetery List';
                    Image = Item;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_Cemetery List";
                    RunPageView = SORTING("Cemetery Code")
                                  ORDER(Descending);
                }
                action("Cemetery Conformation")
                {
                    Caption = 'Cemetery Conformation';
                    Image = Item;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_Cemetery Conformation";
                }
                action("Cemetery Option")
                {
                    Caption = 'Cemetery Option';
                    Image = ItemGroup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_Cemetery Option";
                }
                action("Unit Price Type")
                {
                    Caption = 'Unit Price Type';
                    Image = ItemCosts;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_Unit Price Type";
                }
                action("Cemetery Digits")
                {
                    Caption = 'Cemetery Digits';
                    Image = ItemTracking;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_Cemetery Digits";
                }
                action("Tree Type")
                {
                    Caption = 'Tree Type';
                    Image = ItemVariant;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DK_Tree Type";
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        _UploadCemetery: Codeunit "DK_Upload Cemetery";
    begin

        Clear(_UploadCemetery);
        if _UploadCemetery.CheckError(Rec) then
            Rec."Data Validation" := Rec."Data Validation"::Error
        else
            Rec."Data Validation" := Rec."Data Validation"::Normal;

        FieldStyle;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        _UploadCemetery: Codeunit "DK_Upload Cemetery";
    begin

        Clear(_UploadCemetery);
        if _UploadCemetery.CheckError(Rec) then
            Rec."Data Validation" := Rec."Data Validation"::Error
        else
            Rec."Data Validation" := Rec."Data Validation"::Normal;

        FieldStyle;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        FieldStyle;
    end;

    var
        ErrorStyle: Text[20];
        MSG001: Label 'Please assign a value to %1 first';

    local procedure ErrorValidation()
    begin
    end;

    local procedure FieldStyle()
    begin

        if Rec."Data Validation" = Rec."Data Validation"::Error then
            ErrorStyle := 'Attention'
        else
            ErrorStyle := '';
    end;
}

