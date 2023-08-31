page 50026 "DK_Purchase Contract Line Card"
{
    AutoSplitKey = true;
    Caption = 'Purchase Contract Line Card';
    DataCaptionFields = "Contract Date From", "Contract Date To";
    DelayedInsert = true;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "DK_Purchase Contract Line";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Control14)
                {
                    ShowCaption = false;
                    field("Line No."; Rec."Line No.")
                    {
                    }
                    field("Contract Date From"; Rec."Contract Date From")
                    {
                    }
                    field("Contract Date To"; Rec."Contract Date To")
                    {
                    }
                    field("Contract Amount"; Rec."Contract Amount")
                    {
                    }
                    field(Remarks; Rec.Remarks)
                    {
                    }
                    field("Department Code"; Rec."Department Code")
                    {
                        Importance = Additional;
                    }
                    field("Department Name"; Rec."Department Name")
                    {
                    }
                }
                group(Contents)
                {
                    Caption = 'Contents';
                    field(WorkContents; WorkContents)
                    {
                        MultiLine = true;
                        ShowCaption = false;

                        trigger OnValidate()
                        begin
                            Rec.SetContents(WorkContents);
                        end;
                    }
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
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        WorkContents := Rec.GetContents;
        GetHeaderNotice;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Contract Date From" := WorkDate;
        GetHeaderNotice;
    end;

    var
        WorkContents: Text;
        MSG001: Label 'Please cancel the %1.';


    procedure GetHeaderNotice()
    var
        _PurchaseContract: Record "DK_Purchase Contract";
    begin
        _PurchaseContract.Reset;
        _PurchaseContract.SetRange("No.", Rec."Purchase Contract No.");
        _PurchaseContract.SetRange(Notice, true);
        if _PurchaseContract.FindSet then begin
            Error(MSG001, _PurchaseContract.FieldCaption(Notice));
        end;

        _PurchaseContract.SetRange(Notice);
        _PurchaseContract.SetRange("Automatic Extension", true);
        if _PurchaseContract.FindSet then begin
            Error(MSG001, _PurchaseContract.FieldCaption("Automatic Extension"));
        end;
    end;
}

