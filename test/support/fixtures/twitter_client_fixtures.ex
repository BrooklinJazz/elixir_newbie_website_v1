defmodule ElixirNewbie.TwitterClientFixtures do
  def valid_tweets do
    %{
      data: [
        %{
          author_id: "1",
          created_at: "2022-10-06T12:05:42.000Z",
          edit_history_tweet_ids: ["1577993499005407232"],
          id: "1577993499005407232",
          text: "Lorem ipsum 1"
        },
        %{
          author_id: "1",
          created_at: "2022-10-06T03:15:33.000Z",
          edit_history_tweet_ids: ["1577860082230267904"],
          id: "1577860082230267904",
          text: "Lorem ipsum 2"
        },
        %{
          author_id: "2",
          created_at: "2022-10-07T23:51:17.000Z",
          edit_history_tweet_ids: ["1577808675984605184"],
          id: "1577808675984605184",
          text: "Lorem ipsum 3"
        },
        %{
          author_id: "3",
          created_at: "2022-10-08T23:48:24.000Z",
          edit_history_tweet_ids: ["1577807952186048512"],
          id: "1577807952186048512",
          text: "Lorem ipsum 4"
        }
      ],
      includes: %{
        users: [
          %{
            id: "1",
            name: "name1",
            profile_image_url: "https://teste.com/profile1.png",
            username: "username1",
            verified: false
          },
          %{
            id: "2",
            name: "name2",
            profile_image_url: "https://teste.com/profile2.png",
            username: "username2",
            verified: false
          },
          %{
            id: "3",
            name: "name3",
            profile_image_url: "https://teste.com/profile3.png",
            username: "username3",
            verified: true
          }
        ]
      },
      meta: %{
        newest_id: "1577993499005407232",
        oldest_id: "1577745724892135427",
        result_count: 4
      }
    }
  end
end
