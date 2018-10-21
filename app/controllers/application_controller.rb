class ApplicationController < ActionController::Base
  before_action :set_locale

  protected

  # 全リンクにlocale情報をセットする
  def default_url_options(options = {})
    options.merge(locale: locale)
  end

  # リンクの多言語化に対応する
  def set_locale
    I18n.locale = locale
  end

  def locale
    @locale ||= params[:locale]
  end

  def require_data(redirect_url, *klass)
    notices = []
    klass.each do |k|
      notices << t('helpers.notice.require_data', model: k.model_name.human) unless k.exists?
    end
    return if notices.blank?

    redirect_to redirect_url, notice: notices
  end
end
