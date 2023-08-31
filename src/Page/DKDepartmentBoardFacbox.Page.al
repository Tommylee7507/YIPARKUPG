page 50162 "DK_Department Board Facbox"
{
    Caption = 'Department Board Facbox';
    CardPageID = "DK_Department Board";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DK_Department Board";
    SourceTableView = SORTING("No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field(Title; Rec.Title)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Contents; Rec.Contents)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("View Document")
            {
                Caption = 'View Document';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _DepartmentBoard: Record "DK_Department Board";
                    _DepartmentBoardList: Page "DK_Department Board List";
                    _Employee: Record DK_Employee;
                begin

                    _DepartmentBoard.Reset;

                    _Employee.Reset;
                    _Employee.SetRange("ERP User ID", UserId);
                    if _Employee.FindSet then begin
                        _DepartmentBoard.SetFilter("Department Code", '%1|%2', _Employee."Department Code", '');
                    end;

                    Clear(_DepartmentBoardList);
                    _DepartmentBoardList.LookupMode(true);
                    _DepartmentBoardList.SetTableView(_DepartmentBoard);
                    _DepartmentBoardList.SetRecord(_DepartmentBoard);
                    _DepartmentBoardList.RunModal;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        _Employee: Record DK_Employee;
    begin
        _Employee.Reset;
        _Employee.SetRange("ERP User ID", UserId);
        if _Employee.FindSet then begin
            Rec.FilterGroup(2);
            Rec.SetFilter("Department Code", '%1|%2', _Employee."Department Code", '');
            Rec.SetFilter(Date, '%1', WorkDate);
            Rec.FilterGroup(0);
        end;
        if Rec.FindFirst then;
    end;
}

