page 50149 "DK_Today Funeral Subform Card"
{
    // 
    // #2024 :2020-07-15
    //   - Move Field : "Location" - "Field Work Sub Cat. Name" After

    Caption = 'Today Funeral Subform Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Today Funeral Line";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Contract No."; Rec."Contract No.")
                {
                    Importance = Additional;
                }
                field("Field Work Main Cat. Code"; Rec."Field Work Main Cat. Code")
                {
                    Importance = Additional;
                    Visible = false;
                }
                field("Field Work Main Cat. Name"; Rec."Field Work Main Cat. Name")
                {
                    Visible = false;
                }
                field("Field Work Sub Cat. Code"; Rec."Field Work Sub Cat. Code")
                {
                    Importance = Additional;
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field("Temporary Grave Place Code"; Rec."Temporary Grave Place Code")
                {
                    Importance = Additional;
                }
                field("Temporary Grave Place Name"; Rec."Temporary Grave Place Name")
                {
                }
                field("Corpse Line No."; Rec."Corpse Line No.")
                {
                    Enabled = CorpseNoEnable;
                    ToolTip = 'If you are a move the grave, you can select a registered corpse.';
                }
                field(Name; Rec.Name)
                {
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                }
                field("Solar Lunar Calendar"; Rec."Solar Lunar Calendar")
                {
                }
                field(Gender; Rec.Gender)
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
                field("Death Date"; Rec."Death Date")
                {
                }
                field("Laying Date"; Rec."Laying Date")
                {
                }
                field("Move The Grave Date"; Rec."Move The Grave Date")
                {
                    Enabled = CorpseNoEnable;
                }
                field("Death Cause"; Rec."Death Cause")
                {
                }
                field("Death Place"; Rec."Death Place")
                {
                }
                field(Relationship; Rec.Relationship)
                {
                }
                field(Remark; Rec.Remark)
                {
                }
            }
            group(Informatio)
            {
                Caption = 'Informatio';
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
            systempart(Control23; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CorpseEnable;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        _TodayFuneral: Record "DK_Today Funeral";
        _TodayFuneralLine: Record "DK_Today Funeral Line";
    begin
        if _TodayFuneral.Get(Rec."Document No.") then begin
            Rec."Contract No." := _TodayFuneral."Contract No.";
            Rec.Validate("Field Work Main Cat. Code", _TodayFuneral."Field Work Main Cat. Code");
            Rec."Document Type" := _TodayFuneral."Funeral Type";
        end;

        _TodayFuneralLine.Reset;
        _TodayFuneralLine.SetRange("Document No.", Rec."Document No.");
        if _TodayFuneralLine.FindLast then
            Rec."Line No." := _TodayFuneralLine."Line No." + 10000
        else
            Rec."Line No." := 10000;
    end;

    trigger OnOpenPage()
    begin
        CorpseEnable;
    end;

    var
        CorpseNoEnable: Boolean;
        MSG001: Label '%1 is empty.';

    local procedure CorpseEnable()
    var
        _TodayFuneral: Record "DK_Today Funeral";
    begin
        if _TodayFuneral.Get(Rec."Document No.") then begin
            //IF (_TodayFuneral."Contract No." = '') THEN
            //  ERROR(MSG001,_TodayFuneral.FIELDCAPTION("Contract No."));

            if (_TodayFuneral."Funeral Type" = _TodayFuneral."Funeral Type"::Move) then begin
                CorpseNoEnable := true;
                exit;
            end;
        end;

        CorpseNoEnable := false;
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

    local procedure CemetryRegisterRun()
    var
        _CemetryRegister: Report DK_CemetryRegister;
    begin
        _CemetryRegister.SetParam(Rec."Contract No.", Rec."Line No.");
        _CemetryRegister.RunModal;
    end;

    local procedure CemetryLedgerRun()
    var
        _CemetryLedger: Report DK_CemetryLedger;
    begin
        _CemetryLedger.SetParam(Rec."Contract No.", Rec."Line No.");
        _CemetryLedger.RunModal;
    end;
}

