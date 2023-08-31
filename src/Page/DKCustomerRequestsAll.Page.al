page 50265 "DK_Customer Requests All"
{
    Caption = 'Customer Requests List';
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DK_Customer Requests";
    SourceTableView = SORTING("Receipt Date");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Cemetery No."; Rec."Cemetery No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Title; Rec.Title)
                {
                }
                field("Work Division"; Rec."Work Division")
                {
                }
                field("Customer Status"; Rec."Customer Status")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee name"; Rec."Employee name")
                {
                }
                field("Contract No."; Rec."Contract No.")
                {
                }
                field("Main Customer Name"; Rec."Main Customer Name")
                {
                }
                field("Cust. Mobile No."; Rec."Cust. Mobile No.")
                {
                }
                field("Cust. Phone No."; Rec."Cust. Phone No.")
                {
                }
                field("Cust. E-mail"; Rec."Cust. E-mail")
                {
                }
                field("Appl. Name"; Rec."Appl. Name")
                {
                }
                field("Appl. Mobile No."; Rec."Appl. Mobile No.")
                {
                }
                field("Appl. Phone No."; Rec."Appl. Phone No.")
                {
                }
                field("Appl. E-mail"; Rec."Appl. E-mail")
                {
                }
                field("Relationship With Cust."; Rec."Relationship With Cust.")
                {
                }
                field("Field Work Sub Cat. Code"; Rec."Field Work Sub Cat. Code")
                {
                }
                field("Field Work Sub Cat. Name"; Rec."Field Work Sub Cat. Name")
                {
                }
                field("Receipt Method"; Rec."Receipt Method")
                {
                }
                field("Receipt Division"; Rec."Receipt Division")
                {
                }
                field("Receipt Contents"; Rec."Receipt Contents")
                {
                }
                field("Process No."; Rec."Process No.")
                {
                }
                field("Process Date"; Rec."Process Date")
                {
                }
                field("Feedback Date"; Rec."Feedback Date")
                {
                }
                field("Process Content"; Rec."Process Content")
                {
                }
                field(Lawn; Rec.Lawn)
                {
                }
                field("Work Time Spent"; Rec."Work Time Spent")
                {
                }
                field("Work Indicator"; Rec."Work Indicator")
                {
                }
                field("Work Manager"; Rec."Work Manager")
                {
                }
                field("Work Group"; Rec."Work Group")
                {
                }
                field("Work Personnel"; Rec."Work Personnel")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Email Status"; Rec."Email Status")
                {
                }
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
            systempart(Control2; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(View)
            {
                Caption = 'View';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    _CustomerRequests: Record "DK_Customer Requests";
                    _CustomerRequestsCard: Page "DK_Customer Request Card";
                    _CustRequestCompleteCard: Page "DK_Cust. Request Complete Card";
                begin

                    case Rec.Status of
                        Rec.Status::Open,
                        Rec.Status::Post,
                        Rec.Status::Cancel,
                        Rec.Status::Release:
                            begin
                                Clear(_CustomerRequestsCard);
                                _CustomerRequestsCard.LookupMode(true);
                                _CustomerRequestsCard.SetTableView(Rec);
                                _CustomerRequestsCard.SetRecord(Rec);
                                _CustomerRequestsCard.RunModal;
                            end;
                        Rec.Status::Complete,
                        Rec.Status::Impossible:
                            begin
                                Clear(_CustRequestCompleteCard);
                                _CustRequestCompleteCard.LookupMode(true);
                                _CustRequestCompleteCard.SetTableView(Rec);
                                _CustRequestCompleteCard.SetRecord(Rec);
                                _CustRequestCompleteCard.RunModal;
                            end;
                    end;
                end;
            }
            action(OpenCard)
            {
                Caption = 'New';
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunPageMode = Create;

                trigger OnAction()
                begin

                    if Rec.FindSet then begin

                        if _Cemetery.Get(Rec."Cemetery Code") then begin
                            // "Cemetery No." := _Cemetery."Cemetery No.";
                            _Cemetery.CalcFields("Estate Type");
                            if _Cemetery."Estate Type" = _Cemetery."Estate Type"::Charnelhouse then begin
                                AddLine('A');
                                PAGE.Run(PAGE::"DK_Customer Request Card HT", Rec);
                            end else begin
                                AddLine('B');
                                PAGE.Run(PAGE::"DK_Customer Request Card", Rec);
                            end;

                        end else begin
                            Error('Please Check Cemetery No. !!');
                        end;

                    end else begin

                        if DK_Contract.Get(_ContractNo) then begin

                            if _Cemetery.Get(DK_Contract."Cemetery Code") then begin
                                // "Cemetery No." := _Cemetery."Cemetery No.";
                                _Cemetery.CalcFields("Estate Type");
                                if _Cemetery."Estate Type" = _Cemetery."Estate Type"::Charnelhouse then begin

                                    AddLine('B');
                                    PAGE.Run(PAGE::"DK_Customer Request Card HT", Rec);
                                end else begin
                                    AddLine('A');
                                    PAGE.Run(PAGE::"DK_Customer Request Card", Rec);
                                end;

                            end else begin
                                Error('Please Check Cemetery No. !!');
                            end;

                        end;

                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

        Rec.SetRange("Contract No.", _ContractNo);
    end;

    var
        DK_Contract: Record DK_Contract;
        _Cemetery: Record DK_Cemetery;
        _ContractNo: Code[20];
        _UserSetup: Record "User Setup";
        ERR001: Label '‹ÏÔÀ Œ‚‘ñí …Ø‡Ÿ…˜ ‹ÏÔÀí Ž–„³„Ÿ„¾. ýˆ«Àí¯ ‰«— —ŸŒŒÍ. ';
        ERR002: Label '‹ÏÔÀ Œ‚‘ñ ×„ Í“‹‹Ï—¸ - ýˆ«– í “Œ•í …—ŽØ ´‘÷ Žš„Ÿ„¾. ýˆ«Àí¯ ‰«— —ŸŒŒÍ. ';
        ERR003: Label '‹ÏÔÀ Œ‚‘ñ ×„ Í“‹‹Ï—¸ - ×„‘÷° í “Œ•í …—ŽØ ´‘÷ Žš„Ÿ„¾. ýˆ«Àí¯ ‰«— —ŸŒŒÍ. ';
        _Employee: Record DK_Employee;
        FunctionSetup: Record "DK_Function Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;


    procedure SetContract(RecContract: Record DK_Contract)
    begin

        _ContractNo := RecContract."No.";
    end;

    local procedure AddLine(Type: Code[10])
    begin

        if _UserSetup.Get(UserId) then begin

            case Type of
                'A':
                    begin
                        if _UserSetup."DK_Cust Req A" = false then
                            Error(ERR003);

                        Rec.Init;
                        FunctionSetup.Get;
                        FunctionSetup.TestField("Customer Requests Nos.");
                        NoSeriesMgt.InitSeries(FunctionSetup."Customer Requests Nos.", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
                        Rec.Insert;

                        Rec."Service Type" := 0;
                        Rec."Receipt Date" := WorkDate;
                        Rec."Field Work Main Cat. Code" := '005';
                        Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));
                        Rec.Validate("Contract No.", DK_Contract."No.");
                        Rec."Creation Date" := CurrentDateTime;
                        Rec."Creation Person" := UserId;

                        Rec.Modify;





                    end;
                'B':
                    begin
                        if _UserSetup."DK_Cust Req B" = false then
                            Error(ERR003);

                        Rec.Init;
                        FunctionSetup.Get;
                        FunctionSetup.TestField("Customer Requests Nos.");
                        NoSeriesMgt.InitSeries(FunctionSetup."Customer Requests Nos.", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
                        Rec.Insert;


                        Rec."Service Type" := 1;
                        Rec."Receipt Date" := WorkDate;
                        Rec."Field Work Main Cat. Code" := '005';
                        Rec.Validate("Employee No.", _Employee.GetEmployeeNoUserID(UserId));
                        Rec.Validate("Contract No.", DK_Contract."No.");
                        Rec."Creation Date" := CurrentDateTime;
                        Rec."Creation Person" := UserId;
                        Rec.Modify;

                    end;

            end;

        end else begin
            Error(ERR001);
        end;


    end;
}

