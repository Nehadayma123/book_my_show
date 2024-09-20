
  let currentIndex = 0;
  const slides = document.querySelectorAll(".slide");
  const totalSlides = slides.length;

  function showSlide(index) {
    if (index >= totalSlides) {
      currentIndex = 0;
    } else if (index < 0) {
      currentIndex = totalSlides - 1;
    } else {
      currentIndex = index;
    }

    const newTransformValue = `-${currentIndex * 100}%`;
    document.querySelector(
      ".slider"
    ).style.transform = `translateX(${newTransformValue})`;
  }

  function nextSlide() {
    showSlide(currentIndex + 1);
  }

  function prevSlide() {
    showSlide(currentIndex - 1);
  }

  document.querySelector(".prev").addEventListener("click", prevSlide);
  document.querySelector(".next").addEventListener("click", nextSlide);
  setInterval(nextSlide, 3000);
