page 50307 "DK_Interli. Fr. with CRM(Web)"
{
    Caption = 'DK_Interli. Fr. with CRM(Web)';
    DelayedInsert = true;
    DeleteAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Interlink Fr. with CRM Log";

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field(EntryNo; Rec."Entry No.")
                {
                }
                field(ContractNo; Rec."Contract No.")
                {
                }
                field(RelationNo; Rec."Relation No.")
                {
                }
                field(CustomerNo; Rec."Customer No.")
                {
                }
                field(Relation; Rec.Relation)
                {
                }
                field(RecordDel; Rec."Record Del")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
    begin
        if Rec."Data Type" = Rec."Data Type"::Inbound then
            if _CRMDataInterlink.InboundFriendsAndRelatives(Rec) then
                Rec."Applied Date" := Today;
    end;

    trigger OnModifyRecord(): Boolean
    var
        _CRMDataInterlink: Codeunit "DK_CRM Data Interlink";
    begin
        if Rec."Data Type" = Rec."Data Type"::Inbound then
            //IF "Record Del" = TRUE THEN
            //  IF _CRMDataInterlink.InboundFriendsAndRelatives_Delete(Rec) THEN
            if _CRMDataInterlink.InboundFriendsAndRelatives(Rec) then
                Rec."Applied Date" := Today;
    end;
}

