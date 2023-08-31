report 50032 "DK_Change Cemetery Status"
{
    Caption = 'Change Cemetery Status';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Cemetery; DK_Cemetery)
        {
            DataItemTableView = SORTING("Cemetery Code");

            trigger OnAfterGetRecord()
            begin
                case StatusOption of
                    StatusOption::Unsold:
                        Cemetery.Validate(Status, Cemetery.Status::Unsold);
                    StatusOption::BeenTransported:
                        Cemetery.Validate(Status, Cemetery.Status::BeenTransported);
                end;

                Cemetery.Modify;
            end;

            trigger OnPostDataItem()
            begin
                Message(MSG002);
            end;

            trigger OnPreDataItem()
            begin
                if Cemetery.FindSet then begin
                    repeat
                        case Cemetery.Status of
                            Cemetery.Status::Reserved, Cemetery.Status::Laying, Cemetery.Status::Contracted:
                                begin
                                    Error(MSG004);
                                end;
                            Cemetery.Status::Unsold:
                                begin
                                    if StatusOption = StatusOption::Unsold then
                                        Error(MSG001);
                                end;
                            Cemetery.Status::BeenTransported:
                                begin
                                    if StatusOption = StatusOption::BeenTransported then
                                        Error(MSG001);
                                end;
                        end;
                    until Cemetery.Next = 0;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    Caption = 'Option';
                    field(StatusOption; StatusOption)
                    {
                        Caption = 'Status';
                        OptionCaption = 'Unsold,BeenTransported';
                    }
                    label("only changeable.")
                    {
                        Caption = 'only changeable.';
                        Style = Unfavorable;
                        StyleExpr = TRUE;
                    }
                    label("e change the Status of the cemetery carefully.")
                    {
                        Caption = 'Please change the Status of the cemetery carefully.';
                        Style = Unfavorable;
                        StyleExpr = TRUE;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            Check_CemeteryStatus;
        end;
    }

    labels
    {
    }

    var
        StatusOption: Option Unsold,BeenTransported;
        MSG001: Label 'It cannot be changed to the same Status.';
        MSG002: Label 'This change is complete.';
        MSG003: Label 'Do you really want to change it?';
        MSG004: Label '% 1 cannot be changed.';

    local procedure Check_CemeteryStatus()
    begin

        if Cemetery.FindSet then begin
            if Cemetery.Status = Cemetery.Status::BeenTransported then
                StatusOption := StatusOption::Unsold
            else
                StatusOption := StatusOption::BeenTransported;
        end;
    end;
}

