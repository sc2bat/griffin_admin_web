const String logoSampleImage = 'assets/images/common/logo.png';
// const String logoSampleImage = 'assets/images/common/logo_sample.png';

List<int> dateFixedYearList = List.generate(10, (index) => 2024 + index);
List<int> dateFixedMonthList = List.generate(12, (index) => index + 1);
List<int> dateDayList = List.generate(31, (index) => index + 1);
List<int> timeHourList = List.generate(24, (index) => index);
List<int> timeMinuteList = List.generate(60, (index) => index);
List<String> bookStatusList = ['미예약', '예약중', '예약완료', '예약취소', '오류'];
List<String> payStatusList = ['미결제', '결제전', '결제완료', '결제취소', '오류'];
