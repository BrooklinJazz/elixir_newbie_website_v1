defmodule ElixirNewbie.Twitter do
  @hashtag_elixir_newbie_url "https://api.twitter.com/2/tweets/search/recent?query=has%3Ahashtags%20%23ElixirNewbie"
  def get() do
    token = Application.fetch_env!(:elixir_newbie, :twitter_api_key)


    {:ok, response} = HTTPoison.get(@hashtag_elixir_newbie_url, Authorization: "Bearer #{token}")
    %HTTPoison.Response{body: body} = response
    {:ok, map} = JSON.decode(body)
    %{"data" =>  data} = map
    data

    # JSON.decode("{\"data\":[{\"id\":\"1545836971091644416\",\"text\":\"This is a test tweet. I'm building a Twitter API thing that needs to find this hashtag: #elixirnewbie\"}],\"meta\":{\"newest_id\":\"1545836971091644416\",\"oldest_id\":\"1545836971091644416\",\"result_count\":1}}")
    # curl "https://api.twitter.com/2/tweets/search/recent?query=has%3Ahashtags%20%23ElixirNewbie" -H "Authorization: Bearer "
  end
end

# [%{id: "", text: ""}]

# pattern matching
# json decoding.
# response? %HTTPoison.Response{}
# {:ok, response}
# result =
#   {:ok,
#    %HTTPoison.Response{
#      body:
#        "{\"data\":[{\"id\":\"1545836971091644416\",\"text\":\"This is a test tweet. I'm building a Twitter API thing that needs to find this hashtag: #elixirnewbie\"}],\"meta\":{\"newest_id\":\"1545836971091644416\",\"oldest_id\":\"1545836971091644416\",\"result_count\":1}}",
#      headers: [
#        {"date", "Sat, 09 Jul 2022 19:05:02 UTC"},
#        {"server", "tsa_b"},
#        {"set-cookie",
#         "guest_id_marketing=v1%3A165739350292015597; Max-Age=63072000; Expires=Mon, 08 Jul 2024 19:05:02 GMT; Path=/; Domain=.twitter.com; Secure; SameSite=None"},
#        {"set-cookie",
#         "guest_id_ads=v1%3A165739350292015597; Max-Age=63072000; Expires=Mon, 08 Jul 2024 19:05:02 GMT; Path=/; Domain=.twitter.com; Secure; SameSite=None"},
#        {"set-cookie",
#         "personalization_id=\"v1_ZQ0HQ9u4mw838VbM8+sHSg==\"; Max-Age=63072000; Expires=Mon, 08 Jul 2024 19:05:02 GMT; Path=/; Domain=.twitter.com; Secure; SameSite=None"},
#        {"set-cookie",
#         "guest_id=v1%3A165739350292015597; Max-Age=63072000; Expires=Mon, 08 Jul 2024 19:05:02 GMT; Path=/; Domain=.twitter.com; Secure; SameSite=None"},
#        {"api-version", "2.46"},
#        {"content-type", "application/json; charset=utf-8"},
#        {"cache-control", "no-cache, no-store, max-age=0"},
#        {"content-length", "244"},
#        {"x-access-level", "read"},
#        {"x-frame-options", "SAMEORIGIN"},
#        {"x-xss-protection", "0"},
#        {"x-rate-limit-limit", "450"},
#        {"x-rate-limit-reset", "1657394402"},
#        {"content-disposition", "attachment; filename=json.json"},
#        {"x-content-type-options", "nosniff"},
#        {"x-rate-limit-remaining", "449"},
#        {"strict-transport-security", "max-age=631138519"},
#        {"x-response-time", "71"},
#        {"x-connection-hash", "a2f8c38f481d7e778fa7d68150cf603a5384c7ca9ff025f62e4d5b1f5fe6ea8a"}
#      ],
#      request: %HTTPoison.Request{
#        body: "",
#        headers: [
#          Authorization:
#            "Bearer AAAAAAAAAAAAAAAAAAAAADaTegEAAAAA1h0mee7fwxi9IGXItegyB%2FGjEQ4%3DwN6AIjTPJzdMP4CJfi2KXaecchuOIUOpjrnh3hMkDA7Gv11js1"
#        ],
#        method: :get,
#        options: [],
#        params: %{},
#        url:
#          "https://api.twitter.com/2/tweets/search/recent?query=has%3Ahashtags%20%23ElixirNewbie"
#      },
#      request_url:
#        "https://api.twitter.com/2/tweets/search/recent?query=has%3Ahashtags%20%23ElixirNewbie",
#      status_code: 200
#    }}
