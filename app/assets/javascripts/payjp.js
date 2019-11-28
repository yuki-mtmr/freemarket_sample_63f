$(function(){

  var submit = document.getElementById("token_submit");

  submit.addEventListener('click', function(e){  // 追加するボタンが押されたらイベント発火
    e.preventDefault();  // ボタンを一旦無効化
    Payjp.setPublicKey("pk_test_291a9bada8ad72705456b727");
    var card = {  // 入力されたカード情報を取得
      number: document.getElementById("card_number").value,
      exp_month: document.getElementById("exp_month").value,
      exp_year: document.getElementById("exp_year").value,
      cvc: document.getElementById("cvc").value
    };
    if (card.number == "", card.exp_month == "1", card.exp_year == "2019", card.cvc == "") {
      alert("カード情報が入力されていません。"); // 送られた値がデフォルト値だった場合
    } else { // デフォルト値以外の値が送られてきた場合
      Payjp.createToken(card, function(status, response) {  // トークンを生成
        if (status === 200) {
          $("#card_number").removeAttr("name");
          $("#exp_month").removeAttr("name");
          $("#exp_year").removeAttr("name"); 
          $("#cvc").removeAttr("name");
          $("#card_token").append(
            $('<input type="hidden" name="payjp-token">').val(response.id)
          ); 
          document.inputForm.submit();  // 生成したトークンを送信する準備を整える
          alert("登録が完了しました");
        } else {
          alert("正しいカード情報を入力してください。");
        }
      });
    }
    false
  });
});