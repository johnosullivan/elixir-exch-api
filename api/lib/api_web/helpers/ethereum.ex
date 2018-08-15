defmodule MyAPIHelper.Ethereum do

  @moduledoc """
  

  """

  def getEthAccount(address) do
    { status, balance_hex } = Ethereumex.HttpClient.eth_get_balance(address)
    balance_hex
    |> String.slice(2..-1)
    |> Hexate.to_integer
  end

end