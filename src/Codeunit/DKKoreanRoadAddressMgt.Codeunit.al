codeunit 50100 "DK_Korean Road Address Mgt." ////zzz
{
    // DK_KRADDR1.0
    //   - Create New


    trigger OnRun()
    begin
    end;
    ////zzz++
    // var
    //     KoreanRaodAddressSetup: Record "DK_Korean Road Address Setup";
    //     apiURL: Text;
    //     SourceXMLDoc: DotNet XmlDocument;
    //     XMLHTTPRequestL: DotNet HttpWebRequest;
    //     XMLHTTPResponse: DotNet HttpWebResponse;
    //     MemoryStreamL: DotNet MemoryStream;
    //     MemoryStreamResL: DotNet MemoryStream;
    //     TotalCount: Integer;
    //     TotalPage: Integer;
    //     CurrentPage: Integer;
    //     CountPerPage: Integer;
    //     PageText: Text;
    //     ErrorMsg000: Label 'System Error.';
    //     ErrorMsg001: Label 'This key is not authorized.';
    //     ErrorMsg002: Label 'This site is not authorized.';
    //     ErrorMsg003: Label 'Please connect with normal path.';
    //     ErrorMsg005: Label 'No keyword entered.';
    //     ErrorMsg006: Label 'Please enter the address in detail.';
    //     ErrorMsg100: Label 'Could not find Setup Record. Please contact your administrator.';
    //     ErrorMsg200: Label 'Nothing to delete.';
    //     ConfirmMsg001: Label 'Setup data will be deleted. Do you want to continue?';
    //     Language: Option KOR,ENG;


    // procedure SearchingKoreanAddress(var _tmpList: Record "DK_Korean Road Address Buffer"; _keyword: Text; var _currPage: Integer; _language: Option KOR,ENG; var _totalPage: Integer; var _pageText: Text)
    // begin
    //     //check setup data and activated
    //     if not IsActivated then exit;

    //     if not GetSetup() then exit;

    //     Language := _language;

    //     //create url
    //     CreateURL(_keyword, _currPage, _language);

    //     //Send Http Request
    //     SendHttpRequest;

    //     CheckResponseError(SourceXMLDoc);

    //     GetPageInfo(SourceXMLDoc, _currPage, _totalPage, _pageText);

    //     InsertSearchingKoreanAddressBuffer(_tmpList, SourceXMLDoc, _language);
    // end;

    // local procedure CreateURL(pKeyword: Text; var pCurrPage: Integer; pLanguage: Option KOR,ENG)
    // begin
    //     apiURL := '';
    //     apiURL := KoreanRaodAddressSetup.GetAPIURL(pLanguage);
    //     apiURL += 'currentPage=' + Format(pCurrPage);
    //     apiURL += '&countPerPage=' + Format(KoreanRaodAddressSetup."Count Per Page");
    //     apiURL += '&keyword=' + pKeyword;
    //     apiURL += '&confmKey=' + KoreanRaodAddressSetup.GetAPIKey(pLanguage);
    // end;

    // local procedure SendHttpRequest()
    // begin
    //     if IsNull(SourceXMLDoc) then SourceXMLDoc := SourceXMLDoc.XmlDocument;
    //     if IsNull(XMLHTTPRequestL) then XMLHTTPRequestL := XMLHTTPRequestL.HttpWebRequest;
    //     if IsNull(XMLHTTPResponse) then XMLHTTPResponse := XMLHTTPResponse.HttpWebResponse;

    //     XMLHTTPRequestL := XMLHTTPRequestL.Create(apiURL);
    //     XMLHTTPRequestL.Timeout := 30000;
    //     XMLHTTPRequestL.UseDefaultCredentials(false);
    //     XMLHTTPRequestL.ContentType := 'application/x-www-form-urlencoded';
    //     XMLHTTPRequestL.Method := 'POST';

    //     MemoryStreamL := XMLHTTPRequestL.GetRequestStream;
    //     MemoryStreamL.Flush;
    //     MemoryStreamL.Close;
    //     XMLHTTPResponse := XMLHTTPRequestL.GetResponse;
    //     MemoryStreamResL := XMLHTTPResponse.GetResponseStream;
    //     SourceXMLDoc.Load(MemoryStreamResL);
    //     MemoryStreamResL.Flush;
    //     MemoryStreamResL.Close;
    //     XMLHTTPResponse.Close;
    // end;

    // local procedure CheckResponseError(_SourceXMLDoc: DotNet XmlDocument): Boolean
    // var
    //     XmlNodeList: DotNet XmlNodeList;
    //     i: Integer;
    //     XmlNode: DotNet XmlNode;
    //     ErrMessage: Text;
    //     Msg: Text;
    // begin

    //     XmlNodeList := SourceXMLDoc.SelectNodes('/results/common');
    //     for i := 0 to XmlNodeList.Count - 1 do begin
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('errorCode/text()');

    //         case XmlNode.Value of
    //             '0':
    //                 exit(true);
    //             '-999':
    //                 ErrMessage := ErrorMsg000; //'-999';
    //             'E0001':
    //                 ErrMessage := ErrorMsg001; //'E0001';
    //             'E0002':
    //                 ErrMessage := ErrorMsg002; //'E0002';
    //             'E0003':
    //                 ErrMessage := ErrorMsg003; //'E0003';
    //             'E0005':
    //                 ErrMessage := ErrorMsg005; //'E0005';
    //             'E0006':
    //                 ErrMessage := ErrorMsg006; //'E0006';
    //         end;
    //         Error(ErrMessage);
    //     end;
    // end;

    // local procedure GetPageInfo(_SourceXMLDoc: DotNet XmlDocument; var _currPage: Integer; var _totalPage: Integer; var _pageText: Text)
    // var
    //     XmlNodeList: DotNet XmlNodeList;
    //     i: Integer;
    //     XmlNode: DotNet XmlNode;
    // begin
    //     XmlNodeList := SourceXMLDoc.SelectNodes('/results/common');
    //     for i := 0 to XmlNodeList.Count - 1 do begin
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('totalCount/text()');
    //         Evaluate(TotalCount, XmlNode.Value);
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('currentPage/text()');
    //         Evaluate(_currPage, XmlNode.Value);
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('countPerPage/text()');
    //         Evaluate(CountPerPage, XmlNode.Value);
    //     end;

    //     if TotalCount <> 0 then begin
    //         _totalPage := Round(TotalCount / CountPerPage, 1, '>');
    //         if _totalPage > 100 then _totalPage := 100;
    //     end else begin
    //         _currPage := 0;
    //         _totalPage := 0;
    //     end;

    //     _pageText := StrSubstNo(' %1 / %2 ', _currPage, _totalPage);
    // end;


    // local procedure InsertSearchingKoreanAddressBuffer(var _tmpList: Record "DK_Korean Road Address Buffer"; _SourceXMLDoc: DotNet XmlDocument; _language: Option KOR,ENG)
    // var
    // XmlNodeList: DotNet XmlNodeList;
    // i: Integer;
    // XmlNode: DotNet XmlNode;
    // begin
    // _tmpList.DeleteAll;
    // Clear(_tmpList);

    // XmlNodeList := _SourceXMLDoc.SelectNodes('/results/juso');
    // for i := 0 to XmlNodeList.Count - 1 do begin
    //     with _tmpList do begin
    //         _tmpList.Init;
    //         _tmpList."Entry No." := i;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('roadAddr/text()');
    //         _tmpList.roadAddr := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('jibunAddr/text()');
    //         _tmpList.jibunAddr := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('zipNo/text()');
    //         _tmpList.zipNo := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('admCd/text()');
    //         _tmpList.admCd := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('rnMgtSn/text()');
    //         _tmpList.rnMgtSn := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('bdKdcd/text()');
    //         _tmpList.bdKdcd := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('siNm/text()');
    //         _tmpList.siNm := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('sggNm/text()');
    //         _tmpList.sggNm := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('emdNm/text()');
    //         _tmpList.emdNm := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('liNm/text()');
    //         _tmpList.liNm := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('rn/text()');
    //         _tmpList.rn := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('udrtYn/text()');
    //         _tmpList.udrtYn := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('buldMnnm/text()');
    //         _tmpList.buldMnnm := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('buldSlno/text()');
    //         _tmpList.buldSlno := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('mtYn/text()');
    //         _tmpList.mtYn := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('lnbrMnnm/text()');
    //         _tmpList.lnbrMnnm := XmlNode.Value;
    //         XmlNode := XmlNodeList.Item(i).SelectSingleNode('lnbrSlno/text()');
    //         _tmpList.lnbrSlno := XmlNode.Value;

    //         if _language = _language::KOR then begin
    //             XmlNode := XmlNodeList.Item(i).SelectSingleNode('roadAddrPart1/text()');
    //             _tmpList.roadAddrPart1 := XmlNode.Value;
    //             XmlNode := XmlNodeList.Item(i).SelectSingleNode('roadAddrPart2/text()');
    //             _tmpList.roadAddrPart2 := XmlNode.Value;
    //             XmlNode := XmlNodeList.Item(i).SelectSingleNode('bdMgtSn/text()');
    //             _tmpList.bdMgtSn := XmlNode.Value;
    //             XmlNode := XmlNodeList.Item(i).SelectSingleNode('detBdNmList/text()');
    //             _tmpList.detBdNmList := CopyStr(XmlNode.Value, 1, 250);
    //             XmlNode := XmlNodeList.Item(i).SelectSingleNode('bdNm/text()');
    //             _tmpList.bdNm := XmlNode.Value;
    //             XmlNode := XmlNodeList.Item(i).SelectSingleNode('emdNo/text()');
    //             _tmpList.emdNo := XmlNode.Value;
    //             XmlNode := XmlNodeList.Item(i).SelectSingleNode('engAddr/text()');
    //             _tmpList.engkorAddr := XmlNode.Value;
    //         end else
    //             if _language = _language::ENG then begin
    //                 XmlNode := XmlNodeList.Item(i).SelectSingleNode('korAddr/text()');
    //                 _tmpList.engkorAddr := XmlNode.Value;
    //             end;

    //         _tmpList.Insert;
    //     end;
    // end;
    // end;

    // local procedure GetSetup(): Boolean
    // begin
    //     if not KoreanRaodAddressSetup.Get then
    //         Error(ErrorMsg100);

    //     exit(true);
    // end;

    // local procedure IsActivated(): Boolean
    // begin

    //     if not GetSetup then exit;

    //     with KoreanRaodAddressSetup do begin
    //         TestField(Activated, true);
    //     end;

    //     exit(true);
    // end;
    ////zzz++
    // [EventSubscriber(ObjectType::Page, 21, 'SearchKoreanRoadAddressCustomerCard', '', false, false)]

    // procedure SearchKoreanRoadAddressCustomerCard(var Sender: Page "Customer Card"; var Rec: Record Customer)
    // var
    //     TmpList: Record "DK_Korean Road Address Buffer" temporary;
    // begin
    //     GetSetup;

    //     if PAGE.RunModal(PAGE::"DK_Korean Road Address Lookup", TmpList) = ACTION::LookupOK then begin
    //         Rec.Validate(Address, TmpList.roadAddr);
    //         Rec.Validate("Address 2", '');
    //         Rec.Validate("Post Code", TmpList.zipNo);
    //         Rec.Validate(City, TmpList.siNm);
    //         Rec.Validate("Country/Region Code", KoreanRaodAddressSetup."Default Country/Region Code");
    //         Rec.Modify(false);
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Page, 41, 'SearchKoreanRoadAddressSalesQuote', '', false, false)]

    // procedure SearchKoreanRoadAddressSalesQuote(var Sender: Page "Sales Quote"; var Rec: Record "Sales Header"; Type: Integer)
    // var
    //     TmpList: Record "DK_Korean Road Address Buffer" temporary;
    // begin
    //     GetSetup;

    //     if PAGE.RunModal(PAGE::"DK_Korean Road Address Lookup", TmpList) = ACTION::LookupOK then begin
    //         case Type of
    //             1: //Sell-to
    //                 begin
    //                     Rec."Sell-to Address" := TmpList.roadAddr;
    //                     Rec."Sell-to Address 2" := '';
    //                     Rec."Sell-to Post Code" := TmpList.zipNo;
    //                     Rec."Sell-to City" := TmpList.siNm;
    //                     Rec."Sell-to Country/Region Code" := KoreanRaodAddressSetup."Default Country/Region Code";
    //                 end;
    //             2: //Ship-to
    //                 begin
    //                     Rec."Ship-to Address" := TmpList.roadAddr;
    //                     Rec."Ship-to Address 2" := '';
    //                     Rec."Ship-to Post Code" := TmpList.zipNo;
    //                     Rec."Ship-to City" := TmpList.siNm;
    //                     Rec."Ship-to Country/Region Code" := KoreanRaodAddressSetup."Default Country/Region Code";
    //                 end;
    //             3: //bill-to
    //                 begin
    //                     Rec."Bill-to Address" := TmpList.roadAddr;
    //                     Rec."Bill-to Address 2" := '';
    //                     Rec."Bill-to Post Code" := TmpList.zipNo;
    //                     Rec."Bill-to City" := TmpList.siNm;
    //                     Rec."Bill-to Country/Region Code" := KoreanRaodAddressSetup."Default Country/Region Code";
    //                 end;
    //         end;
    //         Rec.Modify(false);
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Page, 5050, 'SearchKoreanRoadAddressContactCard', '', false, false)]

    // procedure SearchKoreanRoadAddressContactCard(var Sender: Page "Contact Card"; var Rec: Record Contact)
    // begin
    // end;
    ////zzz--

    // procedure SearchKoreanRoadAddress(var pAddress: Text[50]; var pAddress2: Text[50]; var pPostCode: Code[20]; var pCity: Text[30]; var pCountryRegionCode: Code[10])
    // var
    //     TmpList: Record "DK_Korean Road Address Buffer" temporary;
    // begin
    //     GetSetup;

    //     if PAGE.RunModal(PAGE::"DK_Korean Road Address Lookup", TmpList) = ACTION::LookupOK then begin

    //         pAddress := CopyStr(TmpList.roadAddr, 1, 50);
    //         pAddress2 := CopyStr(TmpList.roadAddr, 51, 50);
    //         pPostCode := TmpList.zipNo;
    //         pCity := TmpList.siNm;
    //         pCountryRegionCode := KoreanRaodAddressSetup."Default Country/Region Code";

    //     end else begin
    //         /*
    //            pAddress := '';
    //            pAddress2 := '';
    //            pPostCode := '';
    //            pCity := '';
    //            pCountryRegionCode := '';
    //         */
    //     end;

    // end;
    ////zzz++
    // trigger SourceXMLDoc::NodeInserting(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    // begin
    // end;

    // trigger SourceXMLDoc::NodeInserted(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    // begin
    // end;

    // trigger SourceXMLDoc::NodeRemoving(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    // begin
    // end;

    // trigger SourceXMLDoc::NodeRemoved(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    // begin
    // end;

    // trigger SourceXMLDoc::NodeChanging(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    // begin
    // end;

    // trigger SourceXMLDoc::NodeChanged(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    // begin
    // end;
    ////zzz--
}

