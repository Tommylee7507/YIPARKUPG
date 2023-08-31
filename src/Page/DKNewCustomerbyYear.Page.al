page 50206 "DK_New Customer by Year"
{
    Caption = 'New Customer by Year';
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
            group(Option)
            {
                Caption = 'Option';
                field(YearFromFilter; YearFromFilter)
                {
                    Caption = 'Period(Year)';
                    MaxValue = 3000;
                    MinValue = 1900;
                }
                field(YearToFilter; YearToFilter)
                {
                    Caption = '~';
                    MaxValue = 3000;
                    MinValue = 1900;
                }
            }
            repeater(Group)
            {
                field(INTEGER0; Rec.INTEGER0)
                {
                    Caption = 'INTEGER0';
                    Editable = false;
                }
                field(DECIMAL0; Rec.DECIMAL0)
                {
                    Caption = 'DECIMAL0';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        _StatDateFilter: Date;
                        _EndDateFilter: Date;
                    begin
                        //No Of contract
                        if (Rec.DECIMAL0 <> 0) and (Rec.INTEGER0 <> 0) then begin

                            _StatDateFilter := DMY2Date(1, 1, Rec.INTEGER0);
                            _EndDateFilter := DMY2Date(31, 12, Rec.INTEGER0);

                            Contract.Reset;
                            Contract.SetRange("Contract Date", _StatDateFilter, _EndDateFilter);
                            Contract.SetRange("Pay. Remaining Amount", 0);
                            Contract.SetFilter(Status, '%1|%2', Contract.Status::FullPayment, Contract.Status::Revocation);
                            if Contract.FindSet then begin
                                PAGE.RunModal(0, Contract);
                            end;
                        end;
                    end;
                }
                field(DECIMAL1; Rec.DECIMAL1)
                {
                    Caption = 'DECIMAL1';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        _StatDateFilter: Date;
                        _EndDateFilter: Date;
                    begin
                        //No Of First Laying
                        if (Rec.DECIMAL1 <> 0) and (Rec.INTEGER0 <> 0) then begin
                            _StatDateFilter := DMY2Date(1, 1, Rec.INTEGER0);
                            _EndDateFilter := DMY2Date(31, 12, Rec.INTEGER0);

                            Contract.Reset;
                            Contract.SetRange("First Laying Date", _StatDateFilter, _EndDateFilter);
                            Contract.SetRange("Pay. Remaining Amount", 0);
                            Contract.SetFilter(Status, '%1|%2', Contract.Status::FullPayment, Contract.Status::Revocation);
                            if Contract.FindSet then begin
                                PAGE.RunModal(0, Contract);
                            end;
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1100409027>")
            {
                Caption = 'Inquiry';
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    DataInquiry;

                    if Rec.FindFirst then;

                    CurrPage.Update;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

        YearToFilter := Date2DMY(WorkDate, 3);

        Contract.Reset;
        Contract.SetCurrentKey("Contract Date");
        Contract.SetFilter("Contract Date", '<>%1', 0D);
        if Contract.FindSet then begin
            YearFromFilter := Date2DMY(Contract."Contract Date", 3);
            FirstContractYear := YearFromFilter;
        end else
            YearFromFilter := YearToFilter - 1;

        //Set Public Filter
        Rec.FilterGroup(2);
        Rec.SetRange("USER ID", UserId);
        Rec.SetRange("OBJECT ID", PAGE::"DK_New Customer by Year");
        Rec.FilterGroup(0);
    end;

    var
        YearFromFilter: Integer;
        YearToFilter: Integer;
        Window: Dialog;
        MSG001: Label 'Analyzing Data...\\';
        Contract: Record DK_Contract;
        FirstContractYear: Integer;


    procedure DataInquiry()
    var
        _RecNo: Integer;
        _TotRecNo: Integer;
        _Date: Record Date;
        _StatDateFilter: Date;
        _EndDateFilter: Date;
        _Contract: Record DK_Contract;
        _LoopYear: Integer;
    begin

        Clear(Window);
        Window.Open(MSG001 + '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');

        Rec.Reset;
        if Rec.FindFirst then
            Rec.DeleteAll;

        _Date.Reset;
        _Date.SetCurrentKey("Period Type", "Period Start");
        _Date.SetRange("Period Type", _Date."Period Type"::Year);

        if FirstContractYear > YearFromFilter then
            _Date.SetRange("Period Start", DMY2Date(1, 1, FirstContractYear), DMY2Date(1, 1, YearToFilter))
        else
            _Date.SetRange("Period Start", DMY2Date(1, 1, YearFromFilter), DMY2Date(1, 1, YearToFilter));
        if _Date.FindSet then begin
            _TotRecNo := _Date.Count;

            repeat
                _LoopYear := Date2DMY(_Date."Period Start", 3);

                _StatDateFilter := DMY2Date(1, 1, _LoopYear);
                _EndDateFilter := DMY2Date(31, 12, _LoopYear);

                _RecNo += 1;

                Rec.Init;
                Rec."USER ID" := UserId;
                Rec."OBJECT ID" := PAGE::"DK_New Customer by Year";
                Rec."Entry No." := _RecNo;
                Rec.INTEGER0 := _LoopYear;

                //New Contract
                _Contract.Reset;
                _Contract.SetRange("Contract Date", _StatDateFilter, _EndDateFilter);
                _Contract.SetRange("Pay. Remaining Amount", 0);
                _Contract.SetFilter(Status, '%1|%2', _Contract.Status::FullPayment, _Contract.Status::Revocation);
                if _Contract.FindSet then
                    Rec.DECIMAL0 := _Contract.Count;

                //First Laying
                _Contract.Reset;
                _Contract.SetRange("First Laying Date", _StatDateFilter, _EndDateFilter);
                _Contract.SetRange("Pay. Remaining Amount", 0);
                _Contract.SetFilter(Status, '%1|%2', _Contract.Status::FullPayment, _Contract.Status::Revocation);
                if _Contract.FindSet then
                    Rec.DECIMAL1 := _Contract.Count;

                Rec.Insert;

                Window.Update(1, Round(_RecNo / _TotRecNo * 10000, 1));
            until _Date.Next = 0;
        end;

        Window.Close;
    end;
}

