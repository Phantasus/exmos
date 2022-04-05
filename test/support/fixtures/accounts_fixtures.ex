defmodule Mos.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mos.Accounts` context.
  """

  def unique_user_email do
    "user#{System.unique_integer()}@example.com"
  end

  def unique_user_username do 
    "user#{System.unique_integer()}"
  end
  
  def valid_user_password do
    "hello world!"
  end

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      username: unique_user_username(),
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Mos.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
