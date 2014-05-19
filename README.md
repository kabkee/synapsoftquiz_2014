Synapsoft 입사퀴즈 풀이 - 2014.05
=

풀이동기
-

  2013년 10월 30일 공지 이후, 2014년 공지가 났다는 소식에 달려가 입사지원 페이지를 확인하였고, 고민할 것 없이 바로 풀이 진행 되었습니다. 이번에도 역시 objective-c를 이용하기로 결정하였습니다.
  
풀이시작
-

###Log창
  사다리 게임의 그래픽이 아닌, 알아보기 쉬운 방법으로 로그창과 커멘드창(입력창)을 만들어 표현하는 방법을 택했습니다.
  'command line tool'로 작성하는 것이 가장 간단한 방법이겠지만, 무엇보다 ios APP으로 만들고 싶었습니다.
  그래서 결국, 로그와 커멘드창이 공존하는 UI로 결정했습니다.

###알고리즘
  실제 사다리게임에서 해당 시작점에서 그림을 그리듯 연상되는 산출 방법으로 표현하고자 노력했으며,
  이런 연산과정이 추후, 이미지 추가 구현에도 사용될 수 있을 것이라는 생각에 적용하였습니다.
  
  세로의 1~ 10번에 해당되는 줄은 y좌표로 정의했고,
  가로의 1~ 6번 시작점은 x좌표로 정의했습니다.
  
  각각의 y는 dictionary의 'key'로, 같은 y에 다수의 x가 존재할 수 있기 때문에 'value'로는 array형으로 x 를 담았습니다.
  
  예) @{ '@1', @[@1],
         '@2', @[@4],
         '@3', @[@2,@5] ... };
  
###알고리즘 주요포인트
  1. x는 연속 할 수다.
  2. x는 한 y 에 최대 3개 가질 수 있다.(6명의 경우, 사다리 최대 3개 설치가능)
  3. 시작 위치(x)에서 y를 늘려가면서(1에서 시작하여, 10까지 숫자를 늘림) 해당 위치에 사다리가 설치되어있는지 체크한다.
  4. 해당 위치에 사다리가 없으면, 해당 위치의 전위치(x-1)을 체크하여, 사다리가 설치되어있으면 x-1 연산을 한다.
  5. 
      26으로 나누어 떨어진단 얘기입니다. 예를 들어 문자 "ZZZ"의 경우 26(26^2 + 26^1 + 1)로 표현되며, 나머지가 0이면 26번째 문자에 해당 된다는 것을 알 수 있습니다.
  2. 나머지가 0이 아닌 경우,
      문자 "Z"에 해당되지 않으며, 26보다 작은 숫자이기 때문에 그에 맞는 문자로 바로 변경을 하면 됩니다.
  3. 나머지를 문자로 변경한 이후,
      Z"에 해당되었다면, 26을 빼주고, 26으로 나누어줍니다. 나누어지지 않은 경우엔 그 해당 나머지를 빼줍니다. 그리고 다시 26으로 나누고, 위와 같은 과정을 반복하며 문자열 하나하나 찾아줍니다. 이때 찾는 순서는 오른쪽 부터(1의자리) 찾게 됩니다.

###재귀함수
  주어진 숫자가 26으로 나누어지지 않을 경우(26보다 작은 숫자)가 생길 때까지, 나머지를 찾아 빼고, 26으로 나누고, 다시 나머지를 찾아 빼고, 26으로 나누는 행위가 반복됩니다. 이는 재귀함수를 사용하여 구현하였고, 공개 소스의 appSolution.m 에 아래의 method 이름으로 구현되어있습니다.
<code> - (void) decTo26s:(int)dec </code>

###테스트케이스 
- SynapsoftQuizTests.m 파일에 unit test 구현
- DATA SOURCE 갯수 확인 (A-Z 26문자 array count)
- 1~26까지의 숫자로 알맞은 알파벳 return 확인
- 숫자 입력하고, 알맞은 문자열 return 확인
- 숫자 입력으로 return된 문자열이 맞는지, 역으로 계산하여 숫자 return 확인

총 4개의 test case 작성되었습니다.

###소스공개
- xcode 5.0.1에서 작성
- iphone retina(4-inch)에서 정상구동 (테스트 완료)
- [소스다운로드][1]

###기타사항
- [소개블로그][2]



[1]: https://drive.google.com/file/d/0B70xA4jw5f9bTXQ0bGstWFpJckE/edit?usp=sharing "Kabkee Google Driver"
[2]: http://kabkee.blogspot.kr/2013/11/objective-c-ios-synapsoft.html "Kabkee Blogger"




