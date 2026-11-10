import Playgrounds
import SwiftUI

struct LifeEvent: Identifiable {
    let id = UUID()
    let eventDescription: String  //發生事件
    let systemIcon: String  // 2. SF Symbol 圖示名稱
    let customImageName: String  // 自定義圖片檔名
    let isFatal: Bool  //是否為死亡事件
}

struct ContentView: View {
    let LifeEvents = [
        LifeEvent(
            eventDescription: "確診肺炎，但住院治療後順利康復。",
            systemIcon: "cross.case.fill",
            customImageName: "1",
            isFatal: false
        ),
        LifeEvent(
            eventDescription: "吃果凍的時候不小心噎到，卒。",
            systemIcon: "fork.knife",
            customImageName: "2",
            isFatal: true
        ),
        LifeEvent(
            eventDescription: "踩到黃金。",
            systemIcon: "dog",
            customImageName: "3",
            isFatal: false
        ),
        LifeEvent(
            eventDescription: "躺在床上忽然被外星人抓走，卒。",
            systemIcon: "exclamationmark",
            customImageName: "4",
            isFatal: true
        ),
        LifeEvent(
            eventDescription: "惹到雷公被劈到燒焦，卒。",
            systemIcon: "bolt.fill",
            customImageName: "5",
            isFatal: true
        ),
        LifeEvent(
            eventDescription: "莫名被塞一千塊。",
            systemIcon: "dollarsign",
            customImageName: "6",
            isFatal: false
        ),
        LifeEvent(
            eventDescription: "肚子痛到不行，結果只是消化不良。",
            systemIcon: "toilet",
            customImageName: "7",
            isFatal: false
        ),
        LifeEvent(
            eventDescription: "被揍了一拳，但是回給對方兩拳。",
            systemIcon: "figure.boxing",
            customImageName: "8",
            isFatal: false
        ),
    ]

    @State private var currentAge: Int = 0  // 當前年齡
    @State private var currentEvent: LifeEvent? = nil  // 當前抽到的事件
    @State private var gamePhase: Int = 0  // 遊戲階段 (0: 未開始, 1: 進行中)
    @State private var isDead: Bool = false  // 是否死亡

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .containerRelativeFrame(.horizontal)
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 15) {
                        Text("活著算你厲害")
                            .font(.custom("SweiDevilSansCJKtc-Bold", size: 52))
                            .foregroundColor(.white)

                        Text("荒謬人生模擬器")
                            .font(.custom("SweiDevilSansCJKtc-Bold", size: 27))
                            .foregroundColor(.white)
                            .shadow(color: .red, radius: 2, x: 3, y: 3)
                        Spacer()
                        
                        // --- 歲數統計卡片 ---
                        VStack(spacing: 5) {
                            Text("目前人生進度")
                                .font(.system(size: 22))
                                .foregroundColor(.white)

                            if gamePhase == 0 {
                                Text("?")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.white)
                            } else if isDead {
                                Text("享年 \(currentAge) 歲 (已登出)")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.red)
                            } else {
                                Text("當前年齡：\(currentAge) 歲")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 115)
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(10)

                        // --- 中間隨機抽籤結果 ---
                        if gamePhase == 0 {
                            // 尚未開始遊戲的提示畫面
                            VStack(spacing: 15) {
                                Image(systemName: "dice.fill")
                                    .font(.system(size: 110))
                                    .foregroundColor(.s)

                                Text("準備好迎接荒謬的一生了嗎？\n點擊下方按鈕隨機開局！")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }
                            .padding(42)
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.12))
                            .cornerRadius(15)
                            .shadow(radius: 5)

                        } else if isDead {
                            // 死亡結算畫面
                            VStack(spacing: 15) {
                                Image(systemName: "tombstone.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.red)

                                Text("R.I.P.")
                                    .font(
                                        .custom("Creepster-Regular", size: 40)
                                    )
                                    .foregroundColor(.red)

                                Text("你的人生在此畫下句點\n享年 \(currentAge) 歲")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)

                                Text("請點擊下方「重生」按鈕喝孟婆湯")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)

                        } else if let event = currentEvent {
                            VStack(alignment: .leading, spacing: 10) {

                                Image(event.customImageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 280)
                                    .clipped()
                                    .cornerRadius(10)

                                
                                HStack {
                                    Image(systemName: event.systemIcon)
                                        .foregroundColor(
                                            event.isFatal ? .red : .cyan
                                        )
                                    if event.isFatal {
                                        Text(" ⚠️ 致命死因！")
                                            .font(.caption2)
                                            .bold()
                                            .foregroundColor(.red)
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal, 5)

                                
                                Text(event.eventDescription)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                    .padding(.horizontal, 5)
                            }
                            .padding(12)
                            .background(Color.white.opacity(0.12))
                            .cornerRadius(15)
                            .transition(.opacity)
                        }
                    }

                    // --- 下方操作按鈕區 ---
                    VStack(spacing: 15) {
                        Button(action: {
                            withAnimation {
                                if gamePhase == 0 {
                                    // 第一次按：開局
                                    currentAge = Int.random(in: 1...40)
                                    currentEvent = LifeEvents.randomElement()
                                    gamePhase = 1
                                    isDead = false
                                } else {
                                    // 如果上一動抽到會死的，按下這顆按鈕就會正式進入結算 (isDead = true)
                                    if let current = currentEvent,
                                        current.isFatal
                                    {
                                        isDead = true
                                    } else {
                                        // 沒死就繼續加年齡、抽下一個
                                        currentAge += Int.random(in: 1...5)
                                        currentEvent =
                                            LifeEvents.randomElement()

                                        // 如果抽到的下一個剛好是死的，讓使用者先看得到這張事件卡，下次按才會變墓碑
                                    }
                                }
                            }
                        }) {
                            Text(
                                gamePhase == 0
                                    ? "🎲 隨機決定我的人生起點"
                                    : (isDead ? "💀 你已經掛了，請按下方重置" : "你的人生下一步 ➡️")
                            )
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                gamePhase == 0
                                    ? Color.red
                                    : (isDead ? Color.gray : Color.red)
                            )
                            .cornerRadius(12)
                        }
                        .disabled(isDead)  // 徹底鎖定，死後不能再點下一步

                        // 重生按鈕
                        Button(action: {
                            withAnimation {
                                currentAge = 0
                                currentEvent = nil
                                gamePhase = 0
                                isDead = false
                            }
                        }) {
                            Text("💀 重生")
                                .font(.system(size: 20))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding(5)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
