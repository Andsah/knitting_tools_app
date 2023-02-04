import 'package:flutter/material.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({
    super.key,
  });

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  bool increaseSelected = true;
  late int currentSts;
  late int incSts;
  Map<String, List<String>> answers = {"round": [], "row": []};

  final _formKey = GlobalKey<FormState>();

  Map<String, List<String>> calculateAnswer() {
    // Long function to sift and sort through all possible scenarios for the answer

    int x = currentSts;
    int b_round = incSts;

    Map<String, List<String>> a = {"round": [], "row": []};

    // round
    int i_round = (x / b_round).truncate();
    int q_round = x % b_round;
    int m_round = b_round - q_round;

    if (m_round.isEven) {
      if (q_round > 0) {
        a["round"]!.add("*k$i_round, m1* ×${(m_round ~/ 2)}");
        a["round"]!.add("*k${i_round + 1}, m1* ×$q_round");
        a["round"]!.add("*k$i_round, m1* ×${(m_round ~/ 2)}");
      } else {
        a["round"]!.add("*k$i_round, m1* ×$m_round");
      }
    } else {
      if (q_round > 0) {
        if (q_round.isEven) {
          a["round"]!.add("*k${i_round + 1}, m1* ×${(q_round ~/ 2)}");
          a["round"]!.add("*k$i_round, m1* ×$m_round");
          a["round"]!.add("*k${i_round + 1}, m1* ×${(q_round ~/ 2)}");
        } else {
          if (m_round - 1 > 0) {
            a["round"]!.add("*k$i_round, m1* ×${((m_round - 1) ~/ 2)}");
          }
          a["round"]!.add("*k${i_round + 1}, m1* ×$q_round");
          a["round"]!.add("*k$i_round, m1* ×${((m_round + 1) ~/ 2)}");
        }
      } else {
        a["round"]!.add("*k$i_round, m1* ×$m_round");
      }
    }

    // row... yeah it's a lot

    if (q_round < 1) {
      if (i_round.isEven) {
        a["row"]!.add("*k${(i_round ~/ 2)}*");
        a["row"]!.add("*m1, k$i_round* ×${m_round - 1}");
        a["row"]!.add("*m1, k${(i_round ~/ 2)}*");
      } else {
        if (i_round > 2) {
          a["row"]!.add("*k${((i_round - 1) ~/ 2)}*");
          a["row"]!.add("*m1, k$i_round* ×${m_round - 1}");
          a["row"]!.add("*k${((i_round + 1) ~/ 2)}*");
        } else {
          a["row"]!.add("*m1, k$i_round* ×${m_round - 1}");
          a["row"]!.add("*k$i_round*");
        }
      }
    } else if (q_round == 1) {
      if (i_round.isEven) {
        a["row"]!.add("*k${(i_round ~/ 2 + 1)}*");
        a["row"]!.add("*m1, k$i_round* ×$m_round");
        a["row"]!.add("*m1, k${(i_round ~/ 2)}*");
      } else {
        a["row"]!.add("*k${((i_round + 1) ~/ 2)}*");
        a["row"]!.add("*m1, k$i_round* ×$m_round");
        a["row"]!.add("*m1, k${((i_round + 1) ~/ 2)}*");
      }
    } else {
      if (m_round.isEven && m_round > 0) {
        if (i_round.isOdd) {
          a["row"]!.add("k${((i_round + 1) ~/ 2)}");
          a["row"]!.add("*m1, k$i_round* ×${(m_round ~/ 2)}");
          a["row"]!.add("*m1, k${i_round + 1}* ×${q_round - 1}");
          a["row"]!.add("*m1, k$i_round* ×${(m_round ~/ 2)}");
          a["row"]!.add("m1, k${((i_round + 1) ~/ 2)}");
        } else {
          a["row"]!.add("k${(i_round ~/ 2 + 1)}");
          a["row"]!.add("*m1, k$i_round* ×${(m_round ~/ 2)}");
          a["row"]!.add("*m1, k${i_round + 1}* ×${q_round - 1}");
          a["row"]!.add("*m1, k$i_round* ×${(m_round ~/ 2)}");
          a["row"]!.add("m1, k${(i_round ~/ 2)}");
        }
      } else if (m_round == 1) {
        if (i_round.isOdd) {
          a["row"]!.add("k${((i_round + 1) ~/ 2)}");
          a["row"]!.add("m1, k$i_round");
          a["row"]!.add("*m1, k${i_round + 1}* ×${q_round - 1}");
          a["row"]!.add("m1, k${((i_round + 1) ~/ 2)}");
        } else {
          a["row"]!.add("k${(i_round ~/ 2 + 1)}");
          a["row"]!.add("*m1, k$i_round* $m_round");
          a["row"]!.add(
              "*m1, k${i_round + 1}* ×${q_round - 1}"); // for this and below, could put m_round in the middle if q_round is even, possible improvement
          a["row"]!.add("m1, k${(i_round ~/ 2)}");
        }
      } else {
        if (i_round.isOdd) {
          a["row"]!.add("k${((i_round + 1) ~/ 2)}");
          a["row"]!.add("*m1, k$i_round* ×${((m_round - 1) ~/ 2)}");
          a["row"]!.add("*m1, k${i_round + 1}* ×${q_round - 1}");
          a["row"]!.add("*m1, k$i_round* ×${((m_round + 1) ~/ 2)}");
          a["row"]!.add("*m1, k${((i_round + 1) ~/ 2)}*");
        } else {
          a["row"]!.add("k${(i_round ~/ 2 + 1)}");
          a["row"]!.add("*m1, k$i_round* ×${((m_round - 1) ~/ 2)}");
          a["row"]!.add("*m1, k${i_round + 1}* ×${q_round - 1}");
          a["row"]!.add("*m1, k$i_round* ×${((m_round + 1) ~/ 2)}");
          a["row"]!.add("*m1, k${(i_round ~/ 2)}*");
        }
      }
    }

    return a;
  }

  void updateCurrent(int sts) {
    setState(() {
      currentSts = sts;
    });
  }

  void updateInc(int sts) {
    setState(() {
      incSts = sts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202, 197, 250),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                // CURRENT STITCHES
                decoration: const InputDecoration(
                  icon: Icon(Icons.numbers),
                  labelText: 'Current stitches',
                ),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  updateCurrent(int.parse(value));
                },
                onFieldSubmitted: (value) =>
                    {_formKey.currentState!.validate()},
                validator: (value) {
                  if (value == null || value.isEmpty || int.parse(value) < 1) {
                    return 'Please fill in a valid number of stitches';
                  }
                  return null;
                },
              ),
              TextFormField(
                // INCREASE STITCHES
                decoration: const InputDecoration(
                  icon: Icon(Icons.numbers),
                  labelText: 'Increase stitches',
                ),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  updateInc(int.parse(value));
                },
                onFieldSubmitted: (value) =>
                    {_formKey.currentState!.validate()},
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.parse(value) > currentSts ||
                      int.parse(value) < 1) {
                    return 'Please fill in a valid number of stitches';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5);
                        }
                        return Theme.of(context).colorScheme.primary;
                      }),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        answers = calculateAnswer();
                      });
                    }
                  },
                  child: const Text("Calculate")),
              const Text("Increase evenly (round):"),
              Flexible(
                child: answers["round"]!.isNotEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: answers["round"]!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(
                            answers["round"]![index],
                            textAlign: TextAlign.center,
                          ));
                        })
                    : SizedBox.fromSize(),
              ),
              const Text("Increase evenly (row):"),
              Flexible(
                child: answers["row"]!.isNotEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: answers["row"]!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(
                            answers["row"]![index],
                            textAlign: TextAlign.center,
                          ));
                        })
                    : SizedBox.fromSize(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
