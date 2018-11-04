defmodule Avidade.ShelfTest do
  use Avidade.DataCase

  alias Avidade.{Repo, Shelf}
  alias Shelf.Item

  test "it should update existing shelf" do
    [
      %Item{
        id: "1",
        good_until: ~D[2018-11-11],
        description: "Feijão",
        image_url: "img1"
      },
      %Item{
        id: "2",
        good_until: ~D[2018-11-11],
        missing_since: NaiveDateTime.utc_now(),
        description: "Leite",
        image_url: "img2"
      },
      %Item{
        id: "3",
        image_url: "img3"
      }
    ]
    |> Enum.each(&Repo.insert!/1)

    Shelf.update_shelf(%{"2" => %{image_url: "img2v2"}, "4" => %{image_url: "img4"}})

    assert [
             %Item{
               id: "1",
               good_until: ~D[2018-11-11],
               description: "Feijão",
               missing_since: one_missing_date_time,
               image_url: "img1"
             },
             %Item{
               id: "2",
               good_until: ~D[2018-11-11],
               missing_since: nil,
               description: "Leite",
               image_url: "img2v2"
             },
             %Item{
               id: "4",
               image_url: "img4"
             }
           ] = Item |> Repo.all() |> Enum.sort_by(& &1.id)

    refute is_nil(one_missing_date_time)
  end
end
