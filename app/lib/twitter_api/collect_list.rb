module TwitterApi
  class CollectList
    extend TwitterClient

    # List を一意に定めているカラムは id (id_number)
    # 同じ user が同じ name のリストを作成することは「可能」
    # slug は一意になるように定められているようだが、可変
    # slug の命名規則は、nameがアルファベットのみで構成されている場合はそれがそのまま slug となる（スペースは、nameではアンダースコアに代替され、slugではハイフォンに代替される）
    # name が非アルファベットの場合は list, list1, list2... となるようだ（検証中）
    # slug と name は description と同じようなものなので、その一意性は最初から期待するべきではない
    class << self
      def specific_list(list_identify, options = {})
        client.list(list_identify, options)
      end
    end
  end
end
