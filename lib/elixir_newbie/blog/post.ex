defmodule ElixirNewbie.Blog.Post do
  @enforce_keys [:id, :title, :cover_image, :body, :description, :tags, :date]
  defstruct @enforce_keys ++ [:livebook_url, :author_description, :profile_picture, author_name: "Brooklin Myers"]

  def build(filename, attrs, body) do
    [year, month_day_id] = filename |> Path.rootname() |> Path.split() |> Enum.take(-2)
    [month, day, id] = String.split(month_day_id, "-", parts: 3)
    date = Date.from_iso8601!("#{year}-#{month}-#{day}")
    struct!(__MODULE__, [id: id, date: date, body: body] ++ Map.to_list(attrs))
  end
end
