import 'package:basic_banking_app/models/CustomerModel.dart';

class TransactionsHelper {
  TransactionsHelper();
  List<String> freqListIDs = [];
  List<int> freqListFreq = [];

  List<String> getUsersByFrequency({
    required List<CustomerInfo> listOfUsers,
    required List<String> userIDs,
  }) {
    addUsersData(listOfUsers);
    updateFreq(userIDs);
    arrangeFreqList();
    return freqListIDs;
  }

  void addUsersData(List<CustomerInfo> listOfUsers) {
    for (CustomerInfo user in listOfUsers) {
      freqListIDs.add(user.id);
      freqListFreq.add(0);
    }
  }

  void updateFreq(List<String> userIDs) {
    for (String userID in userIDs) {
      for (int i = 0; i < freqListIDs.length; i++) {
        if (freqListIDs[i] == userID) {
          freqListFreq[i]++;
          break;
        }
      }
    }
  }

  void arrangeFreqList() {
    int temp1;
    String temp2;
    for (int i = 0; i < freqListIDs.length; i++) {
      for (int j = i + 1; j < freqListIDs.length; j++) {
        if (freqListFreq[i] < freqListFreq[j]) {
          temp1 = freqListFreq[i];
          freqListFreq[i] = freqListFreq[j];
          freqListFreq[j] = temp1;

          temp2 = freqListIDs[i];
          freqListIDs[i] = freqListIDs[j];
          freqListIDs[j] = temp2;
        }
      }
    }
  }
}
