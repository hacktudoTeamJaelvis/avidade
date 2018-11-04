defmodule Avidade.ShelvesTest do
  use Avidade.DataCase

  alias Avidade.{Repo, Shelves}
  alias Shelves.{Item, Shelf}

  test "it should update existing shelf" do
    Repo.insert!(%Shelf{
      id: 1,
      owner_name: "Bernardo Amorim",
      owner_phone: "+5521999888777",
      lat: 0.0,
      long: 0.0
    })

    Repo.insert!(%Shelf{
      id: 2,
      owner_name: "Bernardo Amorim",
      owner_phone: "+5521999888777",
      lat: 0.0,
      long: 0.0
    })

    [
      %Item{
        id: "1",
        shelf_id: 1,
        good_until: ~D[2018-11-11],
        description: "Feijão",
        image_url: "img1"
      },
      %Item{
        id: "2",
        shelf_id: 1,
        good_until: ~D[2018-11-11],
        missing_since: NaiveDateTime.utc_now(),
        description: "Leite",
        image_url: "img2"
      },
      %Item{
        id: "3",
        shelf_id: 1,
        image_url: "img3"
      },
      %Item{
        id: "1",
        shelf_id: 2,
        image_url: "img3"
      }
    ]
    |> Enum.each(&Repo.insert!/1)

    Shelves.update_shelf(1, %{"2" => %{image_url: "img2v2"}, "4" => %{image_url: "img4"}})

    shelf_1_items = Item |> Repo.all() |> Enum.filter(&(&1.shelf_id == 1))
    shelf_2_items = Item |> Repo.all() |> Enum.filter(&(&1.shelf_id == 2))

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
           ] = shelf_1_items |> Enum.sort_by(& &1.id)

    assert [
             %Item{
               id: "1",
               shelf_id: 2,
               image_url: "img3"
             }
           ] = shelf_2_items

    refute is_nil(one_missing_date_time)
  end
end
