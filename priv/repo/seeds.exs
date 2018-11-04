alias Avidade.{
  Repo,
  Shelf.Item,
  Shelf.Shelf
}

Repo.insert!(%Shelf{
  id: 1,
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
    image_url:
      "https://img.cybercook.uol.com.br/imagens/receitas/972/feijao-1.jpg?w=583&h=350&fit=max"
  },
  %Item{
    id: "2",
    shelf_id: 1,
    good_until: ~D[2018-11-11],
    missing_since: NaiveDateTime.utc_now(),
    description: "Leite",
    image_url: "http://revistaamais.com.br/wp-content/uploads/2016/10/caixa-de-leite.jpg"
  },
  %Item{
    id: "3",
    shelf_id: 1,
    image_url: "https://img.estadao.com.br/fotos/crop/960x540/resources/jpg/2/8/1453293531982.jpg"
  }
]
|> Enum.each(&Repo.insert!/1)
