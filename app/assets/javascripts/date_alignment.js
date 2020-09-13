/* date_alignment.js                                 */

const thirty_days = ["4", "6", "9", "11"];

/* 収支登録フォーム内のdate_selectにおいて月選択時に選択可能な日付の整合性を取る */
function dateAlignmentForBookRecordForm()
{
  /* 非表示になっている日付を一度表示状態へ戻す */
  for (let date = 28; date <= 31; date++)
  {
    let $selector = $("select#book_record_record_date_3i option[value='" + date + "']");
    if ($selector.parents().attr("class") == "invalid-date") $selector.unwrap();
  }

  const selected_month = document.getElementById("book_record_record_date_2i").value;
  if (thirty_days.indexOf(selected_month) >= 0)
  {
    /* 31日を非表示にする */
    let $selector = $("select#book_record_record_date_3i option[value='31']");
    $selector.wrap("<span class='invalid-date'>");
    return;
  }
  else if (selected_month === "2")
  {
    /* 29日から31日を非表示にする 29日の時だけ閏年判断 */
    const selected_year = parseInt(document.getElementById("book_record_record_date_1i").value);
    for (let date = 29; date <= 31; date++)
    {
      if (date === 29)
      {
        if( (selected_year % 400 == 0) || (selected_year % 4 == 0 && selected_year % 100 != 0) ) continue;
      }
      let $selector = $("select#book_record_record_date_3i option[value='" + date + "']");
      $selector.wrap("<span class='invalid-date'>");
    }
  }
}

/* 収支登録フォームの登録月を変更する度に整合性を取る。 */
$(document).on("change", "select[id$='i']",function(){ dateAlignmentForBookRecordForm(); });

/* ページ表示時にも呼ぶ */
$(document).on("load", function(){ dateAlignmentForBookRecordForm(); });