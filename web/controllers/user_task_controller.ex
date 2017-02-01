defmodule CodeCorps.UserTaskController do
  use CodeCorps.Web, :controller
  use JaResource

  import CodeCorps.Helpers.Query, only: [id_filter: 2]

  alias CodeCorps.UserTask

  plug :load_resource, model: UserTask, only: [:show], preload: [:task, :user]
  plug :load_and_authorize_changeset, model: UserTask, only: [:create]
  plug :load_and_authorize_resource, model: UserTask, only: [:delete]
  plug JaResource

  @spec filter(Plug.Conn.t, Ecto.Query.t, String.t, list) :: Plug.Conn.t
  def filter(_conn, query, "id", id_list) do
    query |> id_filter(id_list)
  end

  @spec handle_create(Plug.Conn.t, map) :: Ecto.Changeset.t
  def handle_create(_conn, attributes) do
    %UserTask{} |> UserTask.create_changeset(attributes)
  end
end
