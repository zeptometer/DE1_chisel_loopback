import Chisel._

class UartTx(val wtime: Int) extends Module {
  val io = new Bundle {
    val txd = Bool(OUTPUT)
    val enq = Decoupled(UInt(width = 8)).flip
  }
  val time = UInt(wtime, log2Up(wtime))
  val idle :: runnings  = Enum(UInt(), 11)

  val state = Reg(init = idle)
  val count = Reg(init = time)
  val buf   = Reg(init = UInt("b111111111"))

  io.txd := buf(0)

  switch (state) {
    is(idle) {
      when (io.enq.valid) {
        buf := io.enq.bits ## UInt("b0")
        count := time
        state := runnings.last
      }
    }
    is(runnings) {
      when (count === UInt(0)) {
        buf := UInt("b1") ## buf(8, 1)
        count := time
        state := state - UInt(1)
      } .otherwise {
        count := count - UInt(1)
      }
    }
  }

  io.enq.ready := (state === idle)
}

object UartTx {

  def main(args: Array[String]): Unit = {
    val wtime = 0x1458

    chiselMainTest(args, () => Module(new UartTx(wtime))) { c =>
      new UartTxTest(c)
    }
  }

  class UartTxTest(c: UartTx) extends Tester(c) {
    // I won't make test!!!!!!!!!!!!!!!
  }
}
