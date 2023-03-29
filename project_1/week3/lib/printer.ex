defmodule Printer do
  use GenServer

  def start_link(id, sleep_time) do
    GenServer.start_link(__MODULE__, {id, sleep_time}, name: id)
  end

  def init({id, sleep_time}) do
    bad_words = ["arse","arsehole","ass","asshole","balls","bastard","beaver","beef curtains","bellend","bint","bitch","bloodclaat","bloody","bollocks","bugger","bullshit","child-fucker","christ on a bike","christ on a cracker","clunge","cock","cow","crap","cunt","damn","dick","dickhead","effing","fanny","feck","flaps","frigger","fuck","gash","ginger","git","god","goddam","goddamn","godsdamn","hell","holy shit","horseshit","jesus christ","jesus fuck","jesus h. christ","jesus harold christ","jesus wept","jesus, mary and joseph","judas priest","knob","minge","minger","motherfucker","munter","nigga","pissed","pissed off","prick","punani","pussy","shit","shit ass","shitass","slut","snatch","sod","sod-off","son of a bitch","son of a whore","sweet jesus","tit","tits","twat","wanker"]
    {:ok, {id, sleep_time, bad_words}}
  end

  def handle_info(json, {id, sleep_time, bad_words}) do
    Process.sleep(sleep_time)
    tweet_text = json["message"]["tweet"]["text"]
    filtered_text = filter_bad_words(tweet_text, bad_words)
    IO.puts("#{id}: #{filtered_text}")
    {:noreply, {id, sleep_time, bad_words}}
  end

  defp filter_bad_words(text, bad_words) do
    Enum.reduce(bad_words, text, fn word, acc ->
      String.replace(acc, ~r/\b#{word}\b/, String.duplicate("*", String.length(word)))
    end)
  end
end
