page 50212 "DK_E-Sky Data"
{
    Caption = 'E-Sky Data';
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Excel Upload';
    SourceTable = "DK_E-Sky Data";

    layout
    {
        area(content)
        {
            group(Option)
            {
                Caption = 'Option';
                field(cBaseYear; BaseYear)
                {
                    Caption = 'Base Year';

                    trigger OnValidate()
                    begin
                        BaseYear_OnValidate;
                    end;
                }
                field(cBaseMonth; BaseMonth)
                {
                    Caption = 'Base Month';

                    trigger OnValidate()
                    begin
                        BaseMonth_OnValidate;
                    end;
                }
            }
            repeater(Group)
            {
                Editable = false;
                field("Base Year"; Rec."Base Year")
                {
                    Visible = false;
                }
                field("Base Month"; Rec."Base Month")
                {
                    Visible = false;
                }
                field("Line No"; Rec."Line No")
                {
                    Visible = false;
                }
                field("Upload Date"; Rec."Upload Date")
                {
                    Visible = false;
                }
                field(Sequence; Rec.Sequence)
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Cemetery Code"; Rec."Cemetery Code")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field("Main Customer No."; Rec."Main Customer No.")
                {
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                    StyleExpr = StyleTxt;
                }
                field("Field Work Sub Cat. Code"; Rec."Field Work Sub Cat. Code")
                {
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
                field("Cemetery Dig. Code"; Rec."Cemetery Dig. Code")
                {
                }
                field("Cemetery Dig. Name"; Rec."Cemetery Dig. Name")
                {
                }
                field("Cemetery Conf. Code"; Rec."Cemetery Conf. Code")
                {
                }
                field("Cemetery Conf. Name"; Rec."Cemetery Conf. Name")
                {
                }
                field("Death Date"; Rec."Death Date")
                {
                }
                field("Laying Date"; Rec."Laying Date")
                {
                }
                field("Name 3"; Rec."Name 3")
                {
                    StyleExpr = StyleTxt;
                }
                field("Social Security No 2."; Rec."Social Security No 2.")
                {
                    StyleExpr = StyleTxt;
                }
                field("E-Sequence"; Rec."E-Sequence")
                {
                }
                field("Company Name"; Rec."Company Name")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Nationality; Rec.Nationality)
                {
                }
                field(Sex; Rec.Sex)
                {
                    Caption = 'Sex';
                }
                field(Name; Rec.Name)
                {
                    StyleExpr = StyleTxt;
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                }
                field("Date of death Text"; Rec."Date of death Text")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Address; Rec.Address)
                {
                    Visible = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Visible = false;
                }
                field("Reg. Date"; Rec."Reg. Date")
                {
                    Visible = false;
                }
                field("Nationality 2"; Rec."Nationality 2")
                {
                    Visible = false;
                }
                field("Sex 2"; Rec."Sex 2")
                {
                    Visible = false;
                }
                field("Name 2"; Rec."Name 2")
                {
                    StyleExpr = StyleTxt;
                    Visible = false;
                }
                field("Birth Date"; Rec."Birth Date")
                {
                }
                field(Relation; Rec.Relation)
                {
                }
                field("Tel No."; Rec."Tel No.")
                {
                    Visible = false;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Visible = false;
                }
                field("Post Code 2"; Rec."Post Code 2")
                {
                    Visible = false;
                }
                field(Remark; Rec.Remark)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control30; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control29; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(cImportExcel)
            {
                Caption = 'Import Excel';
                Ellipsis = true;
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ImportExcelProcess;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        StyleTxt := Rec.SetStyle;
    end;

    trigger OnOpenPage()
    begin
        PageInit;
        SetRecFilters;
    end;

    var
        BaseYear: Integer;
        BaseMonth: Option "1","2","3","4","5","6","7","8","9","10","11","12";
        StyleTxt: Text;

    local procedure PageInit()
    begin
        BaseYear := Date2DMY(WorkDate, 3);
        BaseMonth := Date2DMY(WorkDate, 2) - 1;
    end;

    local procedure BaseYear_OnValidate()
    begin
        if (BaseYear < 1900) or (BaseYear > 2999) then
            Error('');

        SetRecFilters;
    end;

    local procedure BaseMonth_OnValidate()
    begin
        SetRecFilters;
    end;


    procedure SetRecFilters()
    begin
        Rec.SetRange("Base Year", BaseYear);
        Rec.SetRange("Base Month", BaseMonth);
        CurrPage.Update(false);
    end;

    local procedure ImportExcelProcess()
    var
        _DK_ESkayExcel: Codeunit "DK_E-Skay Excel";
    begin
        _DK_ESkayExcel.ImportExcelFiles(BaseYear, BaseMonth);
    end;
}

