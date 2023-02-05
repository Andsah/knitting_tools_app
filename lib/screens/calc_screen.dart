import 'package:flutter/material.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({
    super.key,
  });

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> with TickerProviderStateMixin {
  bool increaseSelected = true;
  late int currentSts;
  late int changeSts;
  Map<String, List<String>> answers = {"round": [], "row": []};
  late AnimationController curStsController;
  late AnimationController incStsController;
  late Animation<double> curAnimation;
  late Animation<double> incAnimation;

  @override
  void initState() {
    curStsController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });

    incStsController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });

    curAnimation = Tween<double>(begin: 0, end: 0.5).animate(
        CurvedAnimation(parent: curStsController, curve: Curves.fastOutSlowIn));
    super.initState();

    incAnimation = Tween<double>(begin: 0, end: 0.5).animate(
        CurvedAnimation(parent: incStsController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    curStsController.dispose();
    incStsController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  Map<String, List<String>> calcFunc() {
    // Long function to sift and sort through all possible scenarios for the answer

    int x = currentSts;
    int b = changeSts;
    String stitch = "m1";

    Map<String, List<String>> a = {"round": [], "row": []};

    // round
    int i = (x / b).truncate();
    if (!increaseSelected) {
      stitch = "k2tog";
      i = i - 2;
    }
    int q = x % b;
    int m = b - q;

    if (m.isEven) {
      if (q > 0) {
        a["round"]!.add("*k$i, $stitch* ×${(m ~/ 2)}");
        a["round"]!.add("*k${i + 1}, $stitch* ×$q");
        a["round"]!.add("*k$i, $stitch* ×${(m ~/ 2)}");
      } else {
        a["round"]!.add("*k$i, $stitch* ×$m");
      }
    } else {
      if (q > 0) {
        if (q.isEven) {
          a["round"]!.add("*k${i + 1}, $stitch* ×${(q ~/ 2)}");
          a["round"]!.add("*k$i, $stitch* ×$m");
          a["round"]!.add("*k${i + 1}, $stitch* ×${(q ~/ 2)}");
        } else {
          if (m - 1 > 0) {
            a["round"]!.add("*k$i, $stitch* ×${((m - 1) ~/ 2)}");
          }
          a["round"]!.add("*k${i + 1}, $stitch* ×$q");
          a["round"]!.add("*k$i, $stitch* ×${((m + 1) ~/ 2)}");
        }
      } else {
        a["round"]!.add("*k$i, $stitch* ×$m");
      }
    }

    // row... yeah it's a lot

    if (!increaseSelected) {
      if (x ~/ 2 - 2 <= b) {
        a["row"]!.add(
            "Decreasing by one or two stitches less than half the number of total stitches cannot be done evenly across a row.");
        return a;
      }
    } else {
      if (x == b) {
        a["row"]!.add(
            "Increasing by the same number of stitches you already have evenly on a row would require to put two m1:s next to eachother. Drop the number of stitches you want to increase by one and consider making one of the m1:s a centered double increase.");
      }
    }

    if (q == 0) {
      // not sure if the decrease calc works the best but idc about that one as much. Throw it on the backlog.
      if (i.isEven) {
        a["row"]!.add("k${(i ~/ 2)}");
        a["row"]!.add("*$stitch, k$i* ×${m - 1}");
        a["row"]!.add("$stitch, k${(i ~/ 2)}");
      } else {
        if (i > 2) {
          a["row"]!.add("k${((i - 1) ~/ 2)}");
          a["row"]!.add("*$stitch, k$i* ×${m - 1}");
          a["row"]!.add("$stitch, k${((i + 1) ~/ 2)}");
        }
      }
    } else if (q == 1) {
      if (i.isEven) {
        a["row"]!.add("k${(i ~/ 2 + 1)}");
        a["row"]!.add("*$stitch, k$i* ×$m");
        a["row"]!.add("$stitch, k${(i ~/ 2)}");
      } else {
        a["row"]!.add("k${((i + 1) ~/ 2)}");
        a["row"]!.add("*$stitch, k$i* ×$m");
        a["row"]!.add("$stitch, k${((i + 1) ~/ 2)}");
      }
    } else {
      if (m.isEven && m > 0) {
        if (i.isOdd) {
          a["row"]!.add("k${((i + 1) ~/ 2)}");
          a["row"]!.add("*$stitch, k$i* ×${(m ~/ 2)}");
          a["row"]!.add("*$stitch, k${i + 1}* ×${q - 1}");
          a["row"]!.add("*$stitch, k$i* ×${(m ~/ 2)}");
          a["row"]!.add("$stitch, k${((i + 1) ~/ 2)}");
        } else {
          a["row"]!.add("k${(i ~/ 2 + 1)}");
          a["row"]!.add("*$stitch, k$i* ×${(m ~/ 2)}");
          a["row"]!.add("*$stitch, k${i + 1}* ×${q - 1}");
          a["row"]!.add("*$stitch, k$i* ×${(m ~/ 2)}");
          a["row"]!.add("$stitch, k${(i ~/ 2)}");
        }
      } else if (q.isEven) {
        // q IS EVEN
        if (m == 1) {
          if (i.isOdd) {
            a["row"]!.add("k${((i + 1) ~/ 2)}");
            a["row"]!.add("*$stitch, k${i + 1}* ×$q");
            a["row"]!.add("$stitch, k${((i - 1) ~/ 2)}");
          } else {
            a["row"]!.add("k${i ~/ 2}");
            a["row"]!.add("*$stitch, k${i + 1}* ×$q");
            a["row"]!.add("$stitch, k${i ~/ 2}");
          }
        } else {
          // m >= 3
          if (i.isOdd) {
            a["row"]!.add("k${((i + 1) ~/ 2)}");
            a["row"]!.add("*$stitch, k$i* ×${((m - 1) ~/ 2)}");
            a["row"]!.add("*$stitch, k${i + 1}* ×${q - 1}");
            a["row"]!.add("*$stitch, k$i* ×${((m + 1) ~/ 2)}");
            a["row"]!.add("$stitch, k${((i + 1) ~/ 2)}");
          } else {
            a["row"]!.add("k${(i ~/ 2)}");
            a["row"]!.add("*$stitch, k$i* ×${((m - 1) ~/ 2)}");
            a["row"]!.add("*$stitch, k${i + 1}* ×$q");
            a["row"]!.add("*$stitch, k$i* ×${((m - 1) ~/ 2)}");
            a["row"]!.add("$stitch, k${(i ~/ 2)}");
          }
        }
      } else {
        // q IS ODD >= 3
        if (m == 1) {
          if (i.isOdd) {
            a["row"]!.add("k${((i + 1) ~/ 2)}");
            a["row"]!.add("*$stitch, k${i + 1}* ×${(q - 1) ~/ 2}");
            a["row"]!.add("$stitch, k$i");
            a["row"]!.add("*$stitch, k${i + 1}* ×${(q - 1) ~/ 2}");
            a["row"]!.add("$stitch, k${((i + 1) ~/ 2)}");
          } else {
            a["row"]!.add("k${(i ~/ 2 + 1)}");
            a["row"]!.add("*$stitch, k${i + 1}* ×${(q - 1) ~/ 2}");
            a["row"]!.add("*$stitch, k$i* ×$m");
            a["row"]!.add("*$stitch, k${i + 1}* ×${(q - 1) ~/ 2}");
            a["row"]!.add("$stitch, k${(i ~/ 2)}");
          }
        } else {
          // m >= 3
          if (i.isOdd) {
            a["row"]!.add("k${((i + 1) ~/ 2)}");
            a["row"]!.add("*$stitch, k${i + 1}* ×${(q - 1) ~/ 2}");
            a["row"]!.add("*$stitch, k$i* ×$m");
            a["row"]!.add("*$stitch, k${i + 1}* ×${(q - 1) ~/ 2}");
            a["row"]!.add("*$stitch, k${((i + 1) ~/ 2)}*");
          } else {
            a["row"]!.add("k${(i ~/ 2)}");
            a["row"]!.add("*$stitch, k$i* ×${(m - 1) ~/ 2}");
            a["row"]!.add("*$stitch, k${i + 1}* ×$q");
            a["row"]!.add("*$stitch, k$i* ×${(m - 1) ~/ 2}");
            a["row"]!.add("*$stitch, k${(i ~/ 2)}*");
          }
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
      changeSts = sts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: increaseSelected
          ? returnPage(context, "In", calcFunc)
          : returnPage(context, "De", calcFunc),
    );
  }

  SingleChildScrollView returnPage(
      BuildContext context, String prefix, Function calcFunc) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
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
                    setState(() {
                      increaseSelected = !increaseSelected;
                    });
                  },
                  child: const Text("Switch calculator")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        curStsController.forward();
                      } else {
                        curStsController.reverse();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 170,
                        child: TextFormField(
                          // CURRENT STITCHES
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.5 + curAnimation.value),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(30),
                                    right: Radius.circular(30))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    strokeAlign: 0.1,
                                    width: 3,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(30),
                                    right: Radius.circular(30))),
                            hintText: '${prefix}crease stitches',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (String value) {
                            updateCurrent(int.parse(value));
                          },
                          onFieldSubmitted: (value) =>
                              {_formKey.currentState!.validate()},
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.parse(value) < 1) {
                              return 'Please fill in a valid number of stitches';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        incStsController.forward();
                      } else {
                        incStsController.reverse();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 170,
                        child: TextFormField(
                          // Change STITCHES
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.5 + incAnimation.value),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(30),
                                    right: Radius.circular(30))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    strokeAlign: 0.1,
                                    width: 3,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(30),
                                    right: Radius.circular(30))),
                            hintText: '${prefix}crease stitches',
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
                                int.parse(value) < 1 ||
                                prefix == "De" &&
                                    int.parse(value) > currentSts ~/ 2) {
                              return 'Please fill in a valid number of stitches';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  )
                ],
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
                        answers = calcFunc();
                      });
                    }
                  },
                  child: const Text("Calculate")),
              Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.3),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text("${prefix}crease evenly in the round:",
                        style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(
                      height: 250,
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
                    Text("${prefix}crease evenly across a row:",
                        style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(
                      height: 250,
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
                    SizedBox(height: 100)
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
