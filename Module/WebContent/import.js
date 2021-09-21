  var IMP = window.IMP; // 생략해도 괜찮습니다.
  IMP.init("imp00000000"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.
  
	//IMP.request_pay(param, callback) 호출
  IMP.request_pay({ // param
    pg: "html5_inicis",
    pay_method: "card",
    merchant_uid: "ORD20180131-0000011",
    name: "노르웨이 회전 의자",
    amount: 64900,
    buyer_email: "gildong@gmail.com",
    buyer_name: "홍길동",
    buyer_tel: "010-4242-4242",
    buyer_addr: "서울특별시 강남구 신사동",
    buyer_postcode: "01181"
  }, function (rsp) { // callback
    if (rsp.success) {
       
        // 결제 성공 시 로직,
        var msg = '결제가 완료되었습니다.';
        msg += '고유ID : ' + rsp.imp_uid;
        msg += '상점 거래ID : ' + rsp.merchant_uid;
        msg += '결제 금액 : ' + rsp.paid_amount;
        msg += '카드 승인번호 : ' + rsp.apply_num;
        
    } else {
        
        // 결제 실패 시 로직,
         var msg = '결제에 실패하였습니다.';
        msg += '에러내용 : ' + rsp.error_msg;
        
    }
    alert(msg);
  });