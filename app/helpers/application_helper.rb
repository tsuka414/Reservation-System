module ApplicationHelper
  # Pageごとに適切なタイトルを付けるヘルパーです。
  def full_title(page_title = "")
    base_title = "予約管理システム"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # Categoryモデルのレコード分+未定義分のパラメーター配列を初期化する。
  def initialize_parameter_array(user_id)
    # 共通カテゴリとユーザーが個別に作成したカテゴリを全て読み込む
    all_category = Category.where("(user_id = ?) OR (user_id = ?)", 0, user_id)
    parameter_array = []
    all_category.each do |category|
      parameter_array.push([category.name, 0, category.color])
    end

    parameter_array.push(["未分類", 0, "#BBBBBB"])
  end

  # parameterの第3引数(色コード)を別の配列に分離する
  def separate_color_column(parameters)
    colors = []
    parameters.each do |parameter|
      colors.push(parameter[2])
      parameter.delete_at(-1)
    end

    [parameters, colors]
  end

  # 支出額が0であるカテゴリのパラメーターは削除する
  def delete_if_amount_is_zero(parameters)
    parameters.delete_if do |parameter|
      parameter[1].zero?
    end
  end
end
